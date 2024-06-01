module Api
  class QuestionsController < ApplicationController
    def index
      questions =
        if need_user_questions?
          user_id = User.find_by(clerk_id: question_params[:user_id]).try(:id)
          if question_params[:answers].present? && question_params[:answers] != "undefined"
            Question.joins(:answers).where(answers: { user_id: user_id }).order(answers_count: :desc)
          elsif question_params[:comments].present? && question_params[:comments] != "undefined"
            Question.distinct
                    .joins(:user, :comments, answers: :comments)
                    .where(answers: { comments: {user_id: user_id}}, comments: {user_id: user_id})
          else
            fetch_questions(user_id = nil)
          end
        elsif need_condition?
          puts "HERE"
          fetch_questions_by_condition(question_params[:condition])
        else
          fetch_questions(user_id = nil)
        end

      questions = questions.where("lower(title) LIKE '%#{question_params[:query].downcase}%'") if need_search?

      pagy, records = pagy(questions, page: question_params[:page] || 1)

      question_collection = need_popular_questions? ? records.first(5) : records

      tags = fetch_tags(question_collection.pluck(:id)).group_by(&:question_id)

      response = question_collection.map { |qstn| qstn.attributes.merge(tags: tags[qstn.id]) }

      render json: { questions: response, total_pages: pagy.last, total_records: pagy.count }
    end

    def show
      question = fetch_question_by_slug(params[:id])

      return render(json: {}) if question.blank?

      answers = fetch_answers_for_question(question.id)

      if answers.present?
        answer_comments =
          fetch_comments_by_answer_ids(answers.map{ |answer| answer["id"] }.join(", "))
            .group_by{ |answr| answr["commented_to_id"] }

        commented_answers = answers.map{ |answer| answer.merge(comments: answer_comments[answer["id"]]) }
      end

      render json: question.attributes.merge(comments: fetch_comments_by_question_id(question.id),
                                             answers: commented_answers || [],
                                             tags: question.tags.map{ |t| { name: t.name, id: t.id } })
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_by(clerk_id: params["user_id"])

      question = Question.create(title: params["title"],
                                 content: params["content"],
                                 slug: params["title"].gsub(/[^a-zа-яёË]/i, "-")
                                                      .gsub(/-+/, "-")
                                                      .gsub(/\W$/, "")
                                                      .downcase,
                                 published: true,
                                 location: params["location"],
                                 user_id: user.id)

      user.update_column(:questions_count, user.questions_count + 1)

      render json: question.errors.empty? ? question.attributes.merge(status: :success) : { status: :error }
    end

    def destroy
      question = fetch_question_by_slug(params[:id])

      if question_params["condition"]
        attr, cond = question_params["condition"].split(":")

        puts "Question.where(#{{attr => cond}}).destroy_all"
      else
        puts "question.destroy"
      end
    end

    private

    def question_params
      params.permit(:id, :query, :page, :user_id, :answers, :popular, :comments, :condition)
    end

    def need_search?
      question_params[:query].present? && question_params[:query] != "undefined"
    end

    def need_user_questions?
      question_params[:user_id].present? && question_params[:user_id] != "undefined"
    end

    def need_condition?
      question_params[:condition].present? && question_params[:condition] != "undefined"
    end

    def need_popular_questions?
      question_params[:popular].present?
    end

    def fetch_tags(question_id)
      Tag.joins(:question_tags).select(:id, :name, :question_id).where(question_tags: { question_id: question_id })
    end

    def fetch_questions(user_id = nil)
      if user_id
        Question.select(question_sql).where(user_id: user_id).order(answers_count: :desc)
      else
        Question.select(question_sql).order(answers_count: :desc)
      end
    end

    def fetch_questions_by_condition(condition)
      attr, cond = condition.split(":")
      Question.select(question_sql).where(attr => cond)
    end

    def fetch_question_by_slug(question_slug)
      Question.select(question_sql).where(slug: question_slug).first
    end

    def question_sql
      <<-SQL
        Questions.id,
        Questions.content,
        Questions.title,
        Questions.slug,
        Questions.created_at,
        Questions.answers_count,
        Questions.comments_count,
        Questions.published,
        Questions.creation_type,
        (
        SELECT
        Users.name
        FROM
        Users
        WHERE
        Users.id = Questions.user_id
        )
        AS
        user_name,
        (
        SELECT
        Users.picture
        FROM
        Users
        WHERE
        Users.id = Questions.user_id
        )
        AS
        user_image
      SQL
    end

    def fetch_answers_for_question(question_id)
      sql = <<-SQL
        SELECT
        Answers.id,
        Answers.content,
        Answers.created_at,
        Answers.user_id,
        (
        SELECT
        Users.name
        FROM
        Users
        WHERE
        Users.id = Answers.user_id
        )
        AS
        user_name,
        (
        SELECT
        Users.picture
        FROM
        Users
        WHERE
        Users.id = Answers.user_id
        )
        AS
        user_picture
        FROM
        Answers
        WHERE
        Answers.question_id = #{question_id}
        ORDER BY
        Answers.created_at
        DESC
      SQL

      ActiveRecord::Base.connection.execute(sql).to_a
    end

    def fetch_comments_by_question_id(question_id)
      sql = <<-SQL
        SELECT
        Comments.id,
        Comments.content,
        Comments.commented_to_id,
        Comments.created_at,
        (
        SELECT
        Users.name
        FROM
        Users
        WHERE
        Users.id = Comments.user_id
        )
        AS
        user_name
        FROM
        Comments
        WHERE
        Comments.commented_to_id = #{question_id}
        AND
        Comments.commented_to_type = 'Question'
        ORDER BY
        Comments.created_at
        DESC
      SQL

      ActiveRecord::Base.connection.execute(sql).to_a
    end

    def fetch_comments_by_answer_ids(answer_ids)
      sql = <<-SQL
        SELECT
        Comments.id,
        Comments.content,
        Comments.commented_to_id,
        Comments.created_at,
        (
        SELECT
        Users.name
        FROM
        Users
        WHERE
        Users.id = Comments.user_id
        )
        AS
        user_name
        FROM
        Comments
        WHERE
        Comments.commented_to_id IN (#{answer_ids})
        AND
        Comments.commented_to_type = 'Answer'
        ORDER BY
        Comments.created_at
        DESC
      SQL

      ActiveRecord::Base.connection.execute(sql).to_a
    end
  end
end

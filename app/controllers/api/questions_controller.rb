module Api
  class QuestionsController < ApplicationController
    def index
      questions =
        if need_user_questions?
          user_id = User.find_by(id: question_params[:user_id]).try(:id)
          if question_params[:answers].present? && question_params[:answers] != "undefined"
            Question.joins(:answers)
                    .where(questions: { published: true, location: location },
                           answers: { published: true, user_id: user_id })
                    .order(answers_count: :desc)
          elsif question_params[:comments].present? && question_params[:comments] != "undefined"
            Question.distinct
                    .joins(:user, :comments, answers: :comments)
                    .where(questions: { published: true, location: location },
                           answers: { comments: { published: true, user_id: user_id} },
                           comments: { published: true, user_id: user_id })
          else
            fetch_questions(user_id)
          end
        elsif need_condition?
          fetch_questions_by_condition(question_params[:condition])
        else
          fetch_questions
        end

      questions = questions.where("lower(title) LIKE '%#{question_params[:query].downcase}%'") if need_search?

      pagy, records = pagy(questions, page: question_params[:page] || 1)

      question_collection = need_popular_questions? ? fetch_popular_records : records

      tags = fetch_tags(question_collection.map(&:id)).group_by(&:question_id)

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

      user = User.find_by(id: params["author_id"])

      question = Question.create(title: params["title"],
                                 content: params["content"],
                                 slug: params["title"].gsub(/[^\da-zа-яёË]/i, "-")
                                                      .gsub(/-+/, "-")
                                                      .gsub(/\W$/, "")
                                                      .downcase,
                                 published: true,
                                 location: params["location"],
                                 user_id: user.id)

      user.update_column(:questions_count, user.questions_count + 1) if question.errors.empty?

      render json: question.errors.empty? ? question.attributes.merge(status: :success) : { status: :error, errors: question.errors.full_messages }
    end

    def update
      if params["type"] == "all"
        Question.update_all(published: true)
      end
    end

    def destroy
      question = fetch_question_by_slug(params[:id])

      if question_params["condition"].blank?
        question.destroy
      else
        attr, cond = question_params["condition"].split(":")

        Question.where(attr => cond).destroy_all
      end
    end

    private

    def question_params
      params.permit(:id, :query, :page, :user_id, :answers, :popular, :comments, :condition, :location)
    end

    def location
      question_params["location"] ? question_params["location"].upcase : ["RU", "EN"]
    end

    def need_search?
      question_params[:query].present? && question_params[:query] != "undefined"
    end

    def need_user_questions?
      question_params[:user_id].present? && question_params[:user_id] != "undefined"
    end

    def need_condition?
      question_params[:condition] && question_params[:condition] != "undefined"
    end

    def need_popular_questions?
      question_params[:popular].present?
    end

    def fetch_tags(question_id)
      Tag.joins(:question_tags).select(:id, :name, :question_id).where(question_tags: { question_id: question_id })
    end

    def fetch_popular_records
      Question.select(:id, :title, :slug).where(published: true, location: location).order(answers_count: :desc).limit(5)
    end

    def fetch_questions(user_id = nil)
      if user_id
        Question.select(question_sql).where(published: true, user_id: user_id, location: location).order(answers_count: :desc)
      else
        Question.select(question_sql).where(published: true, location: location).order(answers_count: :desc)
      end
    end

    def fetch_questions_by_condition(condition)
      if condition.blank?
        questions = Question.select(question_sql)
      else
        attr, cond = condition.split(":")
        questions = Question.select(question_sql).where(attr => cond)
      end

      if params["sort_by"].present?
        attr, cond = params["sort_by"].split(":")
        questions = questions.order("#{attr} #{cond.upcase}")
      end
      questions
    end

    def fetch_question_by_slug(question_slug)
      attrs =
        if question_slug.scan("@@@publishedfalse").present?
          { slug: question_slug.gsub("@@@publishedfalse", ""), location: location }
        else
          { published: true, slug: question_slug, location: location }
        end
      Question.select(question_sql).where(attrs).first
    end

    def question_sql
      <<-SQL
        Questions.id,
        Questions.content,
        Questions.title,
        Questions.slug,
        Questions.created_at,
        Questions.user_id,
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
        AND
        Answers.published = true
        AND
        Answers.reserved = false
        ORDER BY
        Answers.created_at
        ASC
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
        AND
        Comments.published = true
        AND
        Comments.reserved = false
        ORDER BY
        Comments.created_at
        ASC
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
        AND
        Comments.published = true
        AND
        Comments.reserved = false
        ORDER BY
        Comments.created_at
        ASC
      SQL

      ActiveRecord::Base.connection.execute(sql).to_a
    end
  end
end

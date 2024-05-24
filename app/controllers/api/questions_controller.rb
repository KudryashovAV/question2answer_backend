module Api
  class QuestionsController < ApplicationController
    def index
      questions =
        if need_user_questions?
          user_id = User.find_by(clerk_id: question_params[:user_id]).try(:id)
          if question_params[:answers].present? && question_params[:answers] != "undefined"
            Answer.where(user_id: user_id).map(&:question).flatten.uniq
          else
            Question.select("id, views, title, content, created_at").where(user_id: user_id).order(answers_count: :desc)
          end
        else
          Question.select("id, title, content, created_at, answers_count").order(answers_count: :desc)
        end

      questions = questions.where("lower(title) LIKE '%#{question_params[:query].downcase}%'") if need_search?

      question_collection = need_popular_questions? ? questions.first(5) : questions

      tags = fetch_tags(question_collection.pluck(:id)).group_by(&:question_id)

      response = question_collection.map { |qstn| qstn.attributes.merge(tags: tags[qstn.id]) }

      render json: response
    end

    def show
      question = fetch_question_by_id(params[:id])

      answers = fetch_answers_for_question(question.id)

      answer_comments =
        fetch_comments_by_answer_ids(answers.map{ |answer| answer["id"] }.join(", "))
          .group_by{ |answr| answr["commented_to_id"] }

      commented_answers = answers.map{ |answer| answer.merge(comments: answer_comments[answer["id"]]) }

      render json: question.attributes.merge(comments: fetch_comments_by_question_id(question.id),
                                             answers: commented_answers,
                                             tags: question.tags.map{ |t| { name: t.name, id: t.id } })
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_by(clerk_id: params["user_id"])

      question = Question.create(title: params["title"],
                                 content: params["content"],
                                 location: params["location"],
                                 user_id: user.id)

      render json: question.errors.empty? ? question.attributes.merge(status: :success) : { status: :error }
    end

    private

    def question_params
      params.permit(:query, :page, :user_id, :answers, :popular)
    end

    def need_search?
      question_params[:query].present? && question_params[:query] != "undefined"
    end

    def need_user_questions?
      question_params[:user_id].present? && question_params[:user_id] != "undefined"
    end

    def need_popular_questions?
      question_params[:popular].present?
    end

    def fetch_tags(question_id)
      Tag.joins(:question_tags).select(:id, :name, :question_id).where(question_tags: { question_id: question_id })
    end

    def fetch_question_by_id(question_id)
      sql = <<-SQL
        Questions.id,
        Questions.content,
        Questions.title,
        Questions.created_at,
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
      Question.select(sql).where(id: question_id).first
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

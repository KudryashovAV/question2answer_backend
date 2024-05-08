module Api
  class QuestionsController < ApplicationController
    def index
      questions = Question.select("id, views, title, content, created_at")

      questions = questions.where("lower(title) LIKE '%#{question_params[:query].downcase}%'") if need_search?

      answers = Answer.where(question_id: questions.pluck(:id)).group_by(&:question_id)

      response =
        questions.map { |question| question.attributes.merge(answers_count: answers[question.id].count, tags: question.tags.pluck(:name)) }
                 .sort_by{ |question| question[:answers_count] }
                 .reverse

      render json: response
    end

    def show
      question = Question.find(params[:id])

      answers = Answer.where(question_id: question.id).group_by(&:question_id)

      render json: question.attributes.merge(answers_count: answers[question.id].count,
                                             tags: question.tags.map{ |t| { name: t.name, id: t.id } })
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_by(clerk_id: params["user_id"])

      question = Question.create(title: params["title"],
                                 content: params["content"],
                                 user_id: user.id)

      render json: question.errors.empty? ? question.attributes.merge(status: :success) : { status: :error }
    end

    private

    def question_params
      params.permit(:query, :page)
    end

    def need_search?
      question_params[:query].present? && question_params[:query] != "undefined"
    end
  end
end

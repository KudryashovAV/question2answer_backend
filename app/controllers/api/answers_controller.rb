module Api
  class AnswersController < ApplicationController
    def index
      answers = Answer.where(question_id: params[:question_id])

      response = answers.map { |answer| answer.attributes.merge(user_name: User.find(answer.user_id).user_name) }

      render json: response
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      answer = Answer.create(question_id: params["question"],content: params["content"], user_id: params["author"])

      render json: answer.errors.empty? ? answer.attributes.merge(status: :success) : { status: :error }
    end
  end
end

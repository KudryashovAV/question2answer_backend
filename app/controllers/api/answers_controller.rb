module Api
  class AnswersController < ApplicationController
    skip_forgery_protection

    def index
      answers = Answer.where(question_id: params[:question_id])

      render json: answers
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      answer = Answer.create(question_id: params["question"],content: params["content"], user_id: params["author"])

      render json: { status: answer.errors.empty? ? :success : :error }
    end

    private

    def is_crsf_token_valid?
      request.headers["X-CSRF-TOKEN"] === Digest::MD5.hexdigest(Date.today.strftime("%Y/%m/%d"))
    end
  end
end

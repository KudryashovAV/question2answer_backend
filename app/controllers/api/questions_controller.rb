module Api
  class QuestionsController < ApplicationController
    def index
      questions = Question.select("id, views, title, content, created_at as createdAt")

      render json: questions
    end

    def show
      question = Question.find(params[:id])

      render json: question
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
  end
end

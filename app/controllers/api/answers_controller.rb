module Api
  class AnswersController < ApplicationController
    def index
      answers = Answer.where(published: true, question_id: params[:question_id])

      response = answers.map { |answer| answer.attributes.merge(user_name: User.find(answer.user_id).name) }

      render json: response
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      answer = Answer.create(question_id: params["question"],
                             content: params["content"],
                             user_id: params["author"],
                             reserved: false)

      user = User.find_by(id: params["author"])
      user.update_column(:answers_count, user.answers_count + 1)

      owner = Question.find_by(id: params["question"])
      owner.update_columns(answers_count: owner.answers_count + 1, last_user_answered_type: user.creation_type)

      render json: answer.errors.empty? ? answer.attributes.merge(status: :success) : { status: :error }
    end
  end
end

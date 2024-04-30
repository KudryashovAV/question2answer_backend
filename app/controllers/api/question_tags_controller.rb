module Api
  class QuestionTagsController < ApplicationController
    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      qtag = QuestionTag.find_or_create_by(question_id: params["questionId"], tag_id: params["tagId"])

      render json: qtag.errors.empty? ? qtag.attributes.merge(status: :success) : { status: :error }
    end
  end
end

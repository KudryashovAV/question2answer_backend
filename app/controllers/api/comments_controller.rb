module Api
  class CommentsController < ApplicationController
    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      comment = Comment.create(commented_to_type: params["owner_type"].classify.constantize,
                               commented_to_id: params["owner_id"],
                               content: params["content"],
                               user_id: params["user_id"])

      render json: comment.errors.empty? ? comment.attributes.merge(status: :success) : { status: :error }
    end
  end
end

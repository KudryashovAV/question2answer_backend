module Api
  class CommentsController < ApplicationController
    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      comment = Comment.create(commented_to_type: params["owner_type"].classify.constantize,
                               commented_to_id: params["owner_id"],
                               content: params["content"],
                               reserved: false,
                               user_id: params["user_id"])

      user = User.find_by(id: params["user_id"])
      user.update_column(:comments_count, user.comments_count + 1)

      owner = params["owner_type"].classify.constantize.find_by(id: params["owner_id"])

      owner.update_columns(comments_count: owner.comments_count + 1,
                           last_user_commented_type: user.creation_type)

      render json: comment.errors.empty? ? comment.attributes.merge(status: :success) : { status: :error }
    end
  end
end

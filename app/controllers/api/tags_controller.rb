module Api
  class TagsController < ApplicationController
    def index
      tags = Tag.all

      render json: tags
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      tag = Tag.find_or_create_by(name: params["name"].downcase)

      render json: tag.errors.empty? ? tag.attributes.merge(status: :success) : { status: :error }
    end
  end
end

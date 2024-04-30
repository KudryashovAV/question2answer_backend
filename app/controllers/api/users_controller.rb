module Api
  class UsersController < ApplicationController
    def index
      users = User.all

      render json: users
    end

    def show
      user = User.find_by(clerk_id: params[:id])

      render json: user || []
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_or_create_by(clerk_id: params["clerkId"],
                                    name: params["name"],
                                    user_name: params["username"],
                                    email: params["email"],
                                    picture: params["picture"])

      render json: user.errors.empty? ? user.attributes.merge(status: :success) : { status: :error }
    end
  end
end

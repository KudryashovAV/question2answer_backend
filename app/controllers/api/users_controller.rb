module Api
  class UsersController < ApplicationController
    skip_forgery_protection

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

      render json: { status: user.errors.empty? ? :success : :error }
    end

  end
end

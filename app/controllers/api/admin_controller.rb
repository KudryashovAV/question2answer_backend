module Api
  class AdminController < ApplicationController
    def index
      response = {}
      if params["page_type"] == "user_page"
        response = fetch_users
      end

      render json: response
    end

    def update
      if params["page_type"] == "user_page"
        update_user
      end
    end

    def destroy
      if params["page_type"] == "user_page"
        delete_user
      end
    end

    private

    def update_user
      if params["type"] == "all"
        User.update_all(published: true)
      end
    end

    def delete_user
      user = User.find(params[:id])

      if params["condition"].blank?
        user.destroy
      else
        attr, cond = params["condition"].split(":")
        User.where(attr => cond).destroy_all
      end
    end

    def fetch_users
      users = User.select(user_sql).where(published: true).order(q_count: :desc)
      users = users.where("lower(name) LIKE '%#{params[:query].downcase}%'") if need_search?

      if params["condition"].present?
        attr, cond = params["condition"].split(":")
        users = users.where(attr => cond)
      end

      pagy, response = pagy(users, page: params[:page] || 1)

      { users: response, total_pages: pagy.last, total_records: pagy.count }
    end

    def user_sql
      <<-SQL
        users.id, users.name, users.email, users.creation_type, users.published,
        (SELECT COUNT(*) FROM questions WHERE questions.user_id = users.id) AS q_count,
        (SELECT COUNT(*) FROM answers WHERE answers.user_id = users.id) AS a_count,
        (SELECT COUNT(*) FROM comments WHERE comments.user_id = users.id) AS c_count
      SQL
    end

    def need_search?
      params[:query].present? && params[:query] != "undefined"
    end
  end
end

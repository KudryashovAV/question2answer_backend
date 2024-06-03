module Api
  class AdminController < ApplicationController
    def index
      response = {}
      if params["page_type"] == "user_page"
        response = fetch_users
      elsif params["page_type"] == "answers_page"
        response = fetch_answers
      elsif params["page_type"] == "comments_page"
        response = fetch_comments
      end

      render json: response
    end

    def update
      if params["page_type"] == "user_page"
        update_user
      elsif params["page_type"] == "answers_page"
        update_answer
      elsif params["page_type"] == "comments_page"
        update_comment
      end
    end

    def destroy
      if params["page_type"] == "user_page"
        delete_user
      elsif params["page_type"] == "answers_page"
        delete_answer
      elsif params["page_type"] == "comments_page"
        delete_comment
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
      users = User.select(user_sql)
      users = users.where("lower(name) LIKE '%#{params[:query].downcase}%'") if need_search?

      if params["condition"].present?
        attr, cond = params["condition"].split(":")
        users = users.where(attr => cond)
      end

      if params["sort_by"].present?
        attr, cond = params["sort_by"].split(":")
        users = users.order("#{attr} #{cond.upcase}")
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

    def answer_sql
      <<-SQL
        answers.id, answers.content, answers.reserved, answers.creation_type, answers.published, answers.created_at, answers.user_id,
        (SELECT Users.name FROM Users WHERE Users.id = answers.user_id) AS user_name,
        (SELECT questions.slug FROM questions WHERE questions.id = answers.question_id) AS question_slug
      SQL
    end

    def fetch_answers
      answers = Answer.select(answer_sql)
      answers = answers.where("lower(content) LIKE '%#{params[:query].downcase}%'") if need_search?

      if params["condition"].present?
        attr, cond = params["condition"].split(":")
        answers = answers.where(attr => cond)
      end

      if params["sort_by"].present?
        attr, cond = params["sort_by"].split(":")
        answers = answers.order("#{attr} #{cond.upcase}")
      end

      pagy, response = pagy(answers, page: params[:page] || 1)

      { answers: response, total_pages: pagy.last, total_records: pagy.count }
    end

    def update_answer
      if params["type"] == "all"
        Answer.update_all(published: true)
      end
    end

    def delete_answer
      answer = Answer.find(params[:id])

      if params["condition"].blank?
        answer.destroy
      else
        attr, cond = params["condition"].split(":")
        Answer.where(attr => cond).destroy_all
      end
    end

    def answer_comment_sql
      <<-SQL
        comments.id, comments.commented_to_id, comments.commented_to_type, comments.created_at,
        comments.content, comments.reserved, comments.creation_type, comments.published, comments.user_id,
        (SELECT Users.name FROM Users WHERE Users.id = comments.user_id) AS user_name,
        (SELECT questions.slug FROM questions WHERE questions.id = (
         SELECT answers.question_id FROM answers WHERE answers.id = comments.commented_to_id
        )) as question_slug
      SQL
    end

    def question_comment_sql
      <<-SQL
        comments.id, comments.commented_to_id, comments.commented_to_type, comments.created_at,
        comments.content, comments.reserved, comments.creation_type, comments.published, comments.user_id,
        (SELECT Users.name FROM Users WHERE Users.id = comments.user_id) AS user_name, 
        (SELECT questions.slug FROM questions WHERE questions.id = comments.commented_to_id) as question_slug
      SQL
    end

    def fetch_comments
      q_comments = Comment.select(answer_comment_sql).where(commented_to_type: "Question")
      a_comments = Comment.select(question_comment_sql).where(commented_to_type: "Answer")
      q_comments = q_comments.where("lower(content) LIKE '%#{params[:query].downcase}%'") if need_search?
      a_comments = a_comments.where("lower(content) LIKE '%#{params[:query].downcase}%'") if need_search?

      if params["condition"].present?
        attr, cond = params["condition"].split(":")
        q_comments = q_comments.where(attr => cond)
        a_comments = a_comments.where(attr => cond)
      end

      if params["sort_by"].present?
        attr, cond = params["sort_by"].split(":")
        q_comments = q_comments.order("#{attr} #{cond.upcase}")
        a_comments = a_comments.order("#{attr} #{cond.upcase}")
      end

      comments = a_comments + q_comments

      response = comments.first(params[:page].to_i * 12).last(12)

      { comments: response, total_pages: comments.count / 12, total_records: comments.count }
    end

    def update_comment
      if params["type"] == "all"
        Comment.update_all(published: true)
      end
    end

    def delete_comment
      comment = Comment.find(params[:id])

      if params["condition"].blank?
        comment.destroy
      else
        attr, cond = params["condition"].split(":")
        Comment.where(attr => cond).destroy_all
      end
    end

    def need_search?
      params[:query].present? && params[:query] != "undefined"
    end
  end
end

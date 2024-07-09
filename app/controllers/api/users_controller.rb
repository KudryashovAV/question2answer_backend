module Api
  class UsersController < ApplicationController
    def index
      sql = <<-SQL
        users.id, users.name, users.picture,
        (SELECT COUNT(*) FROM questions WHERE questions.user_id = users.id) AS q_count,
        (SELECT COUNT(*) FROM answers WHERE answers.user_id = users.id) AS a_count,
        (SELECT COUNT(*) FROM comments WHERE comments.user_id = users.id) AS c_count
      SQL

      users = User.select(sql).where(published: true).order(q_count: :desc)
      users = users.where("lower(name) LIKE '%#{user_params[:query].downcase}%'") if need_search?

      begin
        pagy, response = pagy(users, page: user_params[:page] || 1)
      rescue StandardError => error
        page = error.pagy.last
        pagy, response = pagy(users, page: page)
      end

      render json: { users: response, total_pages: pagy.last, total_records: pagy.count }
    end

    def show
      user = params[:email] ? User.find_by(email: params[:email]) : User.find_by(id: params[:id])

      render json: user || []
    end

    def user_info
      user = User.find_by(id: params[:id], published: true)

      return render(json: []) if user.blank?

      questions = Question.where(user_id: params[:id])
      q_answers = Question.joins(:user, :answers).where(answers: {user_id: params[:id]})
      q_comments = Question.distinct
                           .joins(:user, :comments, answers: :comments)
                           .where(answers: { comments: {user_id: params[:id]}}, comments: {user_id: params[:id]})
      q_ids = (questions + q_answers + q_comments).map(&:id)
      tags = Tag.joins(:question_tags)
                .select("tags.id, tags.name, question_tags.question_id")
                .where(question_tags: { question_id: q_ids })
                .group_by(&:question_id)

      response = user.attributes.merge(
        questions: questions.map { |qstn| qstn.attributes.merge(additional_info(user, tags, qstn.id))},
        answer_questions: q_answers.map { |qstn| qstn.attributes.merge(additional_info(user, tags, qstn.id)) },
        comments_questions: q_comments.map { |qstn| qstn.attributes.merge(additional_info(user, tags, qstn.id)) }
      )
      render json: response || []
    end

    def additional_info(user, tags, question_id)
      { user_id: user.id, user_name: user.name, user_image: user.picture, tags: tags[question_id] }
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_by(email: params["email"])
      user = User.create(name: params["name"] || params["email"], password: params["password"], email: params["email"], picture: params["picture"]) unless user

      render json: user.errors.empty? ? user.attributes.merge(status: :success) : { status: :error }
    end

    def update
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?
      debugger
      params = JSON.parse(request.raw_post)

      user = User.find_by(id: params["id"])

      if user
        user.update(name: params["name"],
                    country: params["country"],
                    city: params["city"],
                    location: params["location"],
                    bio: params["bio"],
                    youtube_link: params["youtube_link"],
                    linkedin_link: params["linkedin_link"],
                    facebook_link: params["facebook_link"],
                    instagram_link: params["instagram_link"],
                    github_link: params["github_link"],
                    x_link: params["x_link"])
      end

      render json: user&.errors&.empty? ? user.attributes.merge(status: :success) : { status: :error }
    end


    private

    def user_params
      params.permit(:query, :page)
    end

    def need_search?
      user_params[:query].present? && user_params[:query] != "undefined"
    end
  end
end

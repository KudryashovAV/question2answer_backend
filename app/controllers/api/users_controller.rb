module Api
  class UsersController < ApplicationController
    def index
      users = User.all
      # debugger
      users = users.where("lower(name) LIKE '%#{user_params[:query].downcase}%'") if need_search?

      response =
        users.map { |user| user.attributes.merge(questions_count: user.questions.count, answers_count: user.answers.count) }
            .sort_by{ |user| user[:answers_count] }
            .reverse

      render json: response.first(12)
    end

    def show
      user = User.find_by(clerk_id: params[:id])

      render json: user || []
    end

    def user_info
      user = User.find_by(id: params[:id])

      answers_for_questions = Answer.where(question_id: user.questions.pluck(:id)).uniq.group_by(&:question_id)
      answers_for_answered_questions = Answer.where(question_id: user.answers.map(&:question).pluck(:id)).uniq.group_by(&:question_id)

      questions =
        user.questions.map { |question| question.attributes.merge(answers_count: answers_for_questions[question.id].count, tags: question.tags.map{|x| { id: x.id, name: x.name } }) }
                 .sort_by{ |question| question[:answers_count] }
                 .reverse

      answered_questions = user.answers.map(&:question).map { |question| question.attributes.merge(answers_count: answers_for_answered_questions[question.id].count, tags: question.tags.map{|x| { id: x.id, name: x.name } }) }
                               .sort_by{ |question| question[:answers_count] }
                               .reverse


      response = user.attributes.merge(questions_count: user.questions.count,
                                       answers_count: user.answers.count,
                                       questions: questions.uniq,
                                       answer_questions: answered_questions.uniq)
      render json: response || []
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_or_create_by(clerk_id: params["clerkId"],
                                    name: params["name"],
                                    user_name: params["email"].split("@").first,
                                    email: params["email"],
                                    picture: params["picture"])

      render json: user.errors.empty? ? user.attributes.merge(status: :success) : { status: :error }
    end

    def update
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      user = User.find_by(clerk_id: params["clerkId"])

      user.update(location: params["location"].downcase, name: params["name"], bio: params["bio"])
      #                               name: params["name"],
      #                               user_name: params["email"].split("@").first,
      #                               email: params["email"],
      #                               picture: params["picture"])

      render json: user.errors.empty? ? user.attributes.merge(status: :success) : { status: :error }
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

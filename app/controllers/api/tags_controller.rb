module Api
  class TagsController < ApplicationController
    def index
      tags = search_tags(need_search? ? tag_params[:query].downcase : '', tag_params[:popular] == "true")

      pagy, records = pagy(tags, page: tag_params[:page] || 1)

      render json: { tags: records, total_pages: pagy.last, total_records: pagy.count }
    end

    def show #it has to be in the questions_controller.rb
      tag = Tag.find(tag_params[:id])

      return render(json: { tag: {}, questions: [] }) if tag.blank?

      sql = <<-SQL
        questions.id, questions.title, questions.content,
        questions.created_at, questions.answers_count, questions.user_id,
        (SELECT Users.name FROM Users WHERE Users.id = Questions.user_id) AS user_name,
        (SELECT Users.picture FROM Users WHERE Users.id = Questions.user_id) AS user_image
      SQL

      questions =
        Question.joins(question_tags: :tag).select(sql).where(tag: { id: tag_params[:id] }).order(answers_count: :desc)

      pagy, records = pagy(questions, page: tag_params[:page] || 1)

      response = records.map { |ques| ques.attributes.merge(tags: ques.tags.map{ |t| { name: t.name, id: t.id } }) }

      render json: { tag: tag, questions: response, total_pages: pagy.last, total_records: pagy.count }
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      tag = Tag.find_or_create_by(name: params["name"].downcase)

      render json: tag.errors.empty? ? tag.attributes.merge(status: :success) : { status: :error }
    end

    private

    def tag_params
      params.permit(:id, :query, :page, :popular)
    end

    def need_search?
      tag_params[:query].present? && tag_params[:query] != "undefined"
    end

    def search_tags(query = '', popular)
      sql = <<-SQL
        Tags.id,
        Tags.name,
        COUNT(question_tags.id) as count
      SQL

      tags =  Tag.joins(:question_tags).select(sql).group("tags.id").order(count: :desc)
      tags = tags.where("lower(name) LIKE '%#{query.downcase}%'") if query.present?
      tags = tags.limit(5) if popular

      tags
    end
  end
end

module Api
  class TagsController < ApplicationController
    def index
      tags = if tag_params[:popular] == "true"
               fetch_popular_tags
             else
               search_tags(need_search? ? tag_params[:query].downcase : '')
             end

      render json: tags
    end

    def show
      tag = Tag.find(params[:id])
      questions = tag.questions

      answers = Answer.where(question_id: questions.pluck(:id)).group_by(&:question_id)

      response =
        questions.map { |ques| ques.attributes.merge(answers_count: answers[ques.id].count,
                                                     tags: ques.tags.map{ |t| { name: t.name, id: t.id } }) }
                 .sort_by{ |question| question["answers_count"] }
                 .reverse

      render json: {tag: tag, questions: response }
    end

    def create
      (render json: { status: :bad_request } and return) unless is_crsf_token_valid?

      params = JSON.parse(request.raw_post)

      tag = Tag.find_or_create_by(name: params["name"].downcase)

      render json: tag.errors.empty? ? tag.attributes.merge(status: :success) : { status: :error }
    end

    private

    def tag_params
      params.permit(:query, :page, :popular)
    end

    def need_search?
      tag_params[:query].present? && tag_params[:query] != "undefined"
    end

    def fetch_popular_tags
      sql = <<-SQL
        SELECT
        Tags.id,
        Tags.name,
        (SELECT COUNT(*) From Question_Tags WHERE question_tags.tag_id = Tags.id) AS questions_count
        FROM
        Tags
        ORDER BY
        questions_count
        DESC
        LIMIT
        5
        SQL

      ActiveRecord::Base.connection.execute(sql).to_a
    end

    def search_tags(query = '')
      search_sql = <<-SQL
        SELECT
        Tags.id,
        Tags.name,
        (SELECT COUNT(*) From Question_Tags WHERE question_tags.tag_id = Tags.id) AS questions_count
        FROM
        Tags
        WHERE
        "lower(name) LIKE '%#{query.downcase}%'
        ORDER BY
        questions_count DESC
      SQL

      without_search_sql = <<-SQL
        SELECT
        Tags.id,
        Tags.name,
        (SELECT COUNT(*) From Question_Tags WHERE question_tags.tag_id = Tags.id) AS questions_count
        FROM
        Tags
        ORDER BY
        questions_count DESC
      SQL

      ActiveRecord::Base.connection.execute(query.blank? ? without_search_sql : search_sql).to_a
    end
  end
end

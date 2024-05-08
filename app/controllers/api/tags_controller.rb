module Api
  class TagsController < ApplicationController
    def index
      tags = Tag.all

      question_tags = QuestionTag.where(question_id: tags.pluck(:id)).group_by(&:tag_id)

      response =
        tags.map { |tag| tag.attributes.merge(questions_count: question_tags[tag.id].count) }
                 .sort_by{ |question| question[:questions_count] }
                 .reverse

      render json: response
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
  end
end

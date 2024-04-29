module Api
  class QuestionsController < ApplicationController
    def index
      questions = Question.select("id, views, title, content, created_at as createdAt")

      render json: questions
    end

    def show
      question = Question.find(params[:id])

      render json: question
    end
  end
end

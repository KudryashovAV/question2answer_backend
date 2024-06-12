module Admin
  class ActionsController < Admin::BaseController
    def index
    end

    def create
      unless params["type"] == "activity"
        file = File.open(params["file"])
        file_data = file.read
        days_count = params["duration"].blank? ? 7 : params["duration"].to_i
      end

      if params["type"] == "users"
        UserProcessingJob.perform_now(file_data, days_count)
      elsif params["type"] == "questions"
        QuestionsProcessingJob.perform_now(file_data, days_count)
      elsif params["type"] == "activity"
        ActivityMakerJob.perform_now
      end
    end
  end
end

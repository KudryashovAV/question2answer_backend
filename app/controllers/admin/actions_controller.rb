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

      is_background_jobs_ready = FeatureFlag.find_by(name: "Is background jobs ready?")&.enabled

      if params["type"] == "users"
        if is_background_jobs_ready
          UserProcessingJob.perform_now(file_data, days_count)
        else
          UserCreatorFromTxt.call(file_data, days_count)
        end
      elsif params["type"] == "questions"
        if is_background_jobs_ready
          QuestionsProcessingJob.perform_now(file_data, days_count)
        else
          QuestionEntitiesCreatorFromTxt.call(file_data, days_count)
        end
      elsif params["type"] == "activity"
        if is_background_jobs_ready
          ActivityMakerJob.perform_now
        else
          ActivityMaker.call("question")
          ActivityMaker.call("answer")
        end
      end
    end
  end
end
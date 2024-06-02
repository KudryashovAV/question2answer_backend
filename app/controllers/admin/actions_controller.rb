module Admin
  class ActionsController < Admin::BaseController
    def index
    end

    def create
      file = File.open(params["file"])
      file_data = file.read
      days_count = params["duration"].blank? ? 7 : params["duration"].to_i

      if params["type"] == "users"
        UserCreatorFromTxt.call(file_data, days_count)
      else
        QuestionEntitiesCreatorFromTxt.call(file_data, days_count)
      end
    end
  end
end
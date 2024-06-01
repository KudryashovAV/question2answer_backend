module Admin
  class ActionsController < Admin::BaseController
    def index

    end

    def create

      file = File.open(params["file"])
      file_data = file.read

    end
  end
end
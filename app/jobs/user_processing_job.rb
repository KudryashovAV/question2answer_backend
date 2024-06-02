class UserProcessingJob < ActiveJob::Base
  queue_as :default

  def perform(file_data, days_count)
    UserCreatorFromTxt.call(file_data, days_count)
  end
end

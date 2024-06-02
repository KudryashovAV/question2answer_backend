class QuestionsProcessingJob < ActiveJob::Base
  queue_as :default

  def perform(file_data, days_count)
    QuestionEntitiesCreatorFromTxt.call(file_data, days_count)
  end
end

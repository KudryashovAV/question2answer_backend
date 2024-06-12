class ActivityMakerJob < ActiveJob::Base
  queue_as :default

  def perform
    ActivityMaker.call("question")
    ActivityMaker.call("answer")
  end
end

class ActivityMakerJob < ActiveJob::Base
  queue_as :default

  def perform
    ActivityMaker.call
  end
end
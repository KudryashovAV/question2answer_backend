class ActivityMakerJob < ActiveJob::Base
  queue_as :default

  def perform
    puts "HERE Inside!!!"
    ActivityMaker.call("question")
    ActivityMaker.call("answer")
  end
end

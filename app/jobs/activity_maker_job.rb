class ActivityMakerJob < ActiveJob::Base
  queue_as :default

  def perform
    puts "HERE Inside!!!"
    ActivityMaker.call("question")
    ActivityMaker.call("answer")
    FeatureFlag.create(name: Faker::Lorem.question(word_count: 5), enabled: false)
  end
end

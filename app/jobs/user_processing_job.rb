class UserProcessingJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    10.times do
      puts "AAAAAA"
    end
  end
end
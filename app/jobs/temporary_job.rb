class TemporaryJob < ActiveJob::Base
  queue_as :default

  def perform
    puts "I am a temporary job"
  end
end

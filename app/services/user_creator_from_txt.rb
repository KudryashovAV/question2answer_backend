class UserCreatorFromTxt
  def self.call(file_data, days_count)
    new(file_data, days_count).call
  end

  def initialize(file_data, days_count)
    @file_data = file_data
    @days_count = days_count
  end

  attr_reader :file_data, :days_count

  def call
    users_data = file_data.split("\n")
    users = []
    users_data.each do |data|
      user = User.new

      attributes = data.split("!@#")

      attributes.each do |attr|
        key_value = attr.split(":")

        user.send("#{key_value.shift.strip}=", key_value.join("").strip)

        user.published = false
        user.creation_type = "generated"
        data_of_creation = (1..days_count).to_a.sample
        user.created_at = data_of_creation.days.ago

      rescue StandardError
        next
      end

      users << user
    end

    users.each(&:save)
  end
end
class ActivityMaker
  def self.call
    new.call
  end

  def initialize

  end

  def call
    puts "AAA!!!AAAA #{Time.current}"
  end
end
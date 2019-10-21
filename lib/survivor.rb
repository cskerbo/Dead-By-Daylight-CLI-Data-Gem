require_relative "../lib/scraper.rb"
require_relative "../lib/cli.rb"

class Survivor

  attr_accessor :name, :bio, :description

  @@all = []

  def initialize(survivor_info)
    survivor_info.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_scrape(survivor_hash)
    survivor_hash.each do |survivor|
      self.new(survivor)
    end
  end


  def self.all
    @@all
  end

end

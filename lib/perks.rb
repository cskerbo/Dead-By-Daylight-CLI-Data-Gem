require_relative "../lib/scraper.rb"
require_relative "../lib/cli.rb"

class Perks

  attr_accessor :name, :description

  @@all = []

  def initialize(perk_info)
    perk_info.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_scrape(all_perks)
    all_perks.each do |perk|
      self.new(perk)
    end
  end


  def self.all
    @@all
  end

end

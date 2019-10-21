require_relative "scraper.rb"
require_relative "survivor.rb"
require_relative "killer.rb"
require_relative "cli.rb"

class Player

  attr_accessor :name, :bio, :description

  @@all = []

  def initialize(name, bio)
    @name = name
    @bio = bio
    @@all << self
  end

  def self.all
    @@all
  end

end

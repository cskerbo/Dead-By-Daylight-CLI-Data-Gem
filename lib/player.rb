require_relative "scraper.rb"
require_relative "survivor.rb"
require_relative "killer.rb"
require_relative "cli.rb"

class Player

  attr_accessor :name, :bio, :description, :type

  @@all = []

  def initialize(name, bio, type)
    @name = name
    @bio = bio
    @type = type
    @@all << self
  end

  def self.all
    @@all
  end

end

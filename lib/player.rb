require_relative "scraper.rb"
require_relative "survivor.rb"
require_relative "killer.rb"
require_relative "cli.rb"

class Player

  attr_accessor :name, :bio, :description, :type, :perks

  @@all = []

  def initialize(name, bio, type)
    @name = name
    @bio = bio
    @type = type
    @perks = []
    @@all << self
  end

  def add_perk(perk)
    perks << perk unless perks.include?(perk)
  end

  def destroy_all
    all.clear
  end

  def destroy_perks
    perks.clear
  end

  def self.all
    @@all
  end

end

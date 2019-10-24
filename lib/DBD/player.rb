class DBD::Player

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

  def self.all
    @@all
  end

end

class DBD::Killer

  attr_accessor :name, :bio, :description, :perks

  @@all = []

  def initialize(killer_info)
    killer_info.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_scrape(killer_hash)
    killer_hash.each do |killer|
      self.new(killer)
    end
  end

  def self.all
    @@all
  end

end

class DBD::Perks

  attr_accessor :name, :description, :count, :player

  @@all = []

  def initialize(perk_info)
    perk_info.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_scrape(perk_hash)
    perk_hash.each do |perk|
      self.new(perk)
    end
  end

  def self.all
    @@all
  end

end

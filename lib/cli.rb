require_relative "scraper.rb"
require_relative "survivor.rb"
require_relative "killer.rb"
require_relative "player.rb"
require_relative "perks.rb"
require 'colorize'


class CLI

  attr_accessor :name, :bio, :description

  @@character = []

  def run
    make_survivors
    make_killers
    make_perks
    puts "Welcome to the Dead By Daylight CLI Data Gem. This tool provides access
     to all characters in DBD, their bios, and all available perks.\nWith this\n
     information, you can create your own custom character loadout. Try it now!\n
     Please select either survivor or killer."
    puts "1. Survivor\n".colorize(:blue) + "2. Killer".colorize(:red)
    selection = gets.strip
    character_selection(selection)
    puts "Here is a list of available perks for" + " #{@@character.name}".colorize(:yellow) + ":"
    perk_selection
    puts "#{@@character.name} ".colorize(:yellow) + "can have up to 4 perks in their loadout. "
    puts "Enter the number of the perk you are interested in to view perk details and add it to your loadout:"


  end

  def make_survivors
    survivor_hash = Scraper.scrape_survivors
    Survivor.create_from_scrape(survivor_hash)
  end

  def make_killers
    killer_hash = Scraper.scrape_killers
    Killer.create_from_scrape(killer_hash)
  end

  def make_perks
    perk_hash = Scraper.scrape_perks
    Perks.create_from_scrape(perk_hash)
  end

  def display_all_survivors
    Survivor.all.each.with_index do |survivor, index|
      puts "#{index + 1}." + " #{survivor.name}".colorize(:blue)
      puts "---------------------".colorize(:green)
    end
  end

  def display_all_killers
    Killer.all.each.with_index do |killer, index|
      puts "#{index + 1}." + " #{killer.name}".colorize(:red)
      puts "---------------------".colorize(:green)
    end
  end

  def perk_selection
    counter = 1
    Perks.all.each.with_index do |perk, index|
      if @@character.type == "survivor"
        if perk.count <= 70
          puts "#{index + 1}." + " #{perk.name}".colorize(:yellow)
          puts "---------------------".colorize(:green)
        end
      elsif @@character.type == "killer"
        if perk.count > 70
          puts "#{counter}." + " #{perk.name}".colorize(:yellow)
          puts "---------------------".colorize(:green)
          counter +=1
        end
      end
    end

  end

  def create_player(name, bio, type)
    @@character = Player.new(name, bio, type)
  end

  def character_selection(selection)
    confirmation = "N"
    while confirmation == "N"
      if selection == "1"
        display_all_survivors
        puts "Enter the number of the survivor you would like to learn more about:"
        survivor_selection = gets.strip
        Survivor.all.each.with_index do |survivor, index|
          if survivor_selection.to_i - 1 == index
            puts "Name:" + " #{survivor.name}".colorize(:blue)
            puts "Bio:" + " #{survivor.bio}".colorize(:green)
            puts "Would you like to select this survivor? Enter 'Y' to confirm, 'N' to go back."
            confirmation = gets.strip
            if confirmation == "Y"
              create_player("#{survivor.name}", "#{survivor.bio}", "survivor")
            end
          end
        end
      elsif selection == "2"
        display_all_killers
        puts "Enter the number of the killer you would like to learn more about:"
        killer_selection = gets.strip
        Killer.all.each.with_index do |killer, index|
          if killer_selection.to_i - 1 == index
            puts "Name:" + " #{killer.name}".colorize(:red)
            puts "Bio:" + " #{killer.bio}".colorize(:green)
            puts "Would you like to select this killer? Enter 'Y' to confirm, 'N' to go back."
            confirmation = gets.strip
            if confirmation == "Y"
              create_player("#{killer.name}", "#{killer.bio}", "killer")
            end
          end
        end
      end
    end
  end


end

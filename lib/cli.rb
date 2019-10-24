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
    character_selection
    perk_selection
    display_final_character
    program_exit
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
      puts "#{index + 1}." + " #{killer.name}".colorize(:blue)
      puts "---------------------".colorize(:green)
    end
  end

  def display_survivor_perks
    Perks.all.each.with_index do |perk, index|
      if perk.count <= 71
        puts "#{index + 1}." + " #{perk.name}".colorize(:yellow)
        puts "---------------------".colorize(:green)
      end
    end
  end

  def display_killer_perks
    counter = 1
    Perks.all.each.with_index do |perk, index|
      if perk.count > 71
        puts "#{counter}." + " #{perk.name}".colorize(:yellow)
        puts "---------------------".colorize(:green)
        counter +=1
      end
    end
  end

  def display_final_character
    puts "Your perk loadout is now full and your" + " #{@@character.type} ".colorize(:blue) + "is complete!"
    puts "Here is your complete character summary:"
    puts "----------------------------------------------------------------------"
    Player.all.each do |character|
      puts "Name:".colorize(:red) + " #{character.name}".colorize(:blue)
      puts "Bio:".colorize(:red) + " #{character.bio}".colorize(:green)
      puts "Perk Loadout:".colorize(:red)
      character.perks.each_with_index do |perk, index|
        puts "#{index + 1}. " + "#{perk.name}".colorize(:yellow)
        puts "#{perk.description}".colorize(:cyan)
      end
      puts "--------------------------------------------------------------------"
    end
  end

  def perk_selection
    confirmation = "N"
    while @@character.perks.count != 4
      if @@character.type == "Survivor"
        display_survivor_perks
      elsif @@character.type == "Killer"
        display_killer_perks
      end
      puts "#{@@character.name} ".colorize(:blue) + "can have up to 4 perks in their loadout."
      puts "You currently have" + " #{4 - @@character.perks.count} ".colorize(:red) + "perks left to add to your loadout."
      puts "Enter the number of the perk you are interested in from the list above to view perk details and add it to your loadout:"
      perk_selection = gets.strip
      Perks.all.each.with_index do |perk, index|
        if @@character.type == "Survivor"
          if perk_selection.to_i - 1 == index
            puts "Name:".colorize(:red) + " #{perk.name}".colorize(:yellow)
            puts "Description:".colorize(:red) + " #{perk.description}".colorize(:cyan)
            puts "Would you like to add this perk to your loadout? Enter 'Y' to confirm, 'N' to go back."
            confirmation = gets.strip.upcase
            if confirmation == "Y"
              @@character.add_perk(perk)
            else
              perk_selection
            end
          end
        elsif @@character.type == "Killer"
          if perk_selection.to_i - 1 + 71 == index
            puts "Name:" + " #{perk.name}".colorize(:blue)
            puts "Description:" + " #{perk.description}".colorize(:green)
            puts "Would you like to add this perk to your loadout? Enter 'Y' to confirm, 'N' to go back."
            confirmation = gets.strip.upcase
            if confirmation == "Y"
              @@character.add_perk(perk)
            else
              perk_selection
            end
          end
        end
      end
    end
  end

  def create_player(name, bio, type)
    @@character = Player.new(name, bio, type)
  end

  def character_selection
    confirmation = "N"
    puts <<~HEREDOC
    Welcome to the Dead By Daylight CLI Data Gem!
    \nDead by Daylight is an asymmetrical multiplayer (4v1) horror game where one player
    takes on the role of a brutal Killer and the other four play as Survivors.
    \nYou can choose to be either the Killer or a Survivor. As a Killer, your goal is to sacrifice as many Survivors as possible.
    As a Survivor, your goal is to escape and avoid being caught and killed.
    \nSurvivors and killers each have the option to utilize up to four perks in
    their load-out, that give their characters special abilities.
    \nThis gem allows you to create your own custom character for Dead By Daylight.
    You will be able to navigate through all available survivors and killers, their biographies,
    and perks in order to create your ideal character for the game!\n
    HEREDOC
    puts "To get started, please enter a number for either survivor or killer.\n"
    puts "1. Survivor\n".colorize(:blue) + "2. Killer".colorize(:blue)
    selection = gets.strip
    while confirmation == "N"
      if selection == "1"
        display_all_survivors
        puts "Enter the number of the survivor you would like to learn more about:"
        survivor_selection = gets.strip
        Survivor.all.each.with_index do |survivor, index|
          if survivor_selection.to_i - 1 == index
            puts "Name:".colorize(:red) + " #{survivor.name}".colorize(:blue)
            puts "Bio:".colorize(:red) + " #{survivor.bio}".colorize(:green)
            puts "Would you like to select this survivor? Enter 'Y' to confirm, 'N' to go back."
            confirmation = gets.strip.upcase
            if confirmation == "Y"
            create_player("#{survivor.name}", "#{survivor.bio}", "Survivor")
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
            confirmation = gets.strip.upcase
            if confirmation == "Y"
              create_player("#{killer.name}", "#{killer.bio}", "Killer")
            end
          end
        end
      end
    end
  end

  def program_exit
    puts "Your" + " #{@@character.type} ".colorize(:blue) + "is sure to win with this loadout!"
    puts "Test out different characters and builds to see what works best for you in your games."
    puts "Type 'exit' to quit the program:"
    confirmation = gets.strip
    while confirmation != "exit"
      if confirmation == "exit"
        exit!
      else
        puts "You have entered an invalid selection, try again!"
        confirmation = gets.strip
      end
    end
  end
end

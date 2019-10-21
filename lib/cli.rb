require_relative "scraper.rb"
require_relative "survivor.rb"
require_relative "killer.rb"
require 'colorize'


class CLI

  def run
    make_survivors
    make_killers
    puts "Welcome to the Dead By Daylight CLI Data Gem. This tool provides access
     to all characters in DBD, their bios, and all available perks.\nWith this\n
     information, you can create your own custom character loadout. Try it now!\n
     Please select either survivor or killer."
    puts "1. Survivor\n".colorize(:blue) + "2. Killer".colorize(:red)
    user_input = gets.strip
    if user_input == "1"
      display_all_survivors
      puts "Enter the number of the survivor you would like to learn about:"
      survivor_selection = gets.strip
      display_selected_survivor(survivor_selection)
    elsif user_input == "2"
      display_all_killers
      puts "Enter the number of the survivor you would like to learn about:"
      killer_selection = gets.strip
      display_selected_killer(killer_selection)
    end
  end

  def make_survivors
    survivor_hash = Scraper.scrape_survivors
    Survivor.create_from_scrape(survivor_hash)
  end

  def make_killers
    killer_hash = Scraper.scrape_killers
    Killer.create_from_scrape(killer_hash)
  end

  def display_all_survivors
    Survivor.all.each.with_index do |survivor, index|
      puts "#{index + 1}." + " #{survivor.name}".colorize(:blue)
      puts "---------------------".colorize(:green)
    end
  end

  def display_selected_survivor(survivor_selection)
    Survivor.all.each.with_index do |survivor, index|
      if survivor_selection.to_i - 1 == index
        puts "Name:" + " #{survivor.name}".colorize(:blue)
        puts "Bio:" + " #{survivor.bio}".colorize(:green)
      end
    end
  end

  def display_selected_killer(killer_selection)
    Killer.all.each.with_index do |killer, index|
      if killer_selection.to_i - 1 == index
        puts "Name:" + " #{killer.name}".colorize(:red)
        puts "Bio:" + " #{killer.bio}".colorize(:green)
      end
    end
  end

  def display_all_killers
    Killer.all.each.with_index do |killer, index|
      puts "#{index + 1}." + " #{killer.name}".colorize(:red)
      puts "---------------------".colorize(:green)

    end
  end
end

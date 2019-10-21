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
    puts "1. Survivor\n2. Killer"
    user_input = gets.strip
    if user_input == "1"
      display_survivors
    elsif user_input == "2"
      display_killers
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

  def display_survivors
    counter = 1
    Survivor.all.each do |survivor|
      puts "#{counter}." + " #{survivor.name}".colorize(:blue)
      puts "---------------------".colorize(:green)
      counter += 1
    end
  end

  def display_killers
    counter = 1
    Killer.all.each do |killer|
      puts "#{counter}." + " #{killer.name}".colorize(:blue)
      puts "---------------------".colorize(:green)
      counter += 1
    end
  end
end

require_relative "scraper.rb"
require_relative "survivor.rb"
require 'colorize'


class CLI

  def run
    puts "Welcome to the Dead By Daylight CLI Data Gem. This tool provides access
     to all characters in DBD, their bios, and all available perks.\nWith this\n
     information, you can create your own custom character loadout. Try it now!\n
     Please select either survivor or killer."
    puts "1. Survivor\n2. Killer"
    user_input = gets.strip
    if user_input == "1"
      make_survivors
      display_survivors
    elsif user_input == "2"
      Scraper.scrape_killers
    end
  end

  def make_survivors
    survivor_hash = Scraper.scrape_survivors
    Survivor.create_from_scrape(survivor_hash)
  end

  def display_survivors
    Survivor.all.each do |survivor|
      puts "Name:".colorize(:blue) + " #{survivor.name}"
      puts "Bio:".colorize(:blue) + " #{survivor.bio}"
      puts "---------------------------------------------------------".colorize(:green)
    end
  end
end

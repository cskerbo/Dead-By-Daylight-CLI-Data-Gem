require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_survivors
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Survivors"))
    survivors = []

    survivor_list = page.css('div[style*="flex:1"]')
    survivor_list.each do |survivor|
      name = survivor.css("a").attribute("title").text
      survivors << name
    end
    survivors
  end

  def self.scrape_killers
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
    killers = []

    killer_list = page.css('div#fpkiller.fpbox div.fplinks div.link')
    killer_list.each do |killer|
      name = killer.css('a').text
      killers << name
    end
    killers
  end

  def self.scrape_perks
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Perks"))
    all_perks = []
    survivor_perks = []
    killer_perks = []

    perk_extract = page.css('div.mw-parser-output')
    perk_extract.each do |perk|
      perks_isolated = perk.css('table.wikitable.sortable tr th[2] a[1]')
        perks_isolated.each do |item|
          final_perk = item.attribute('title').text
          all_perks << final_perk
          survivor_perks = all_perks[0...70]
          killer_perks = all_perks[71...133]
      end
    end
  end
end

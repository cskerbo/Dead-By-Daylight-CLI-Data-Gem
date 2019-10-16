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
puts survivors

  end
scrape_survivors

end

require 'nokogiri'
require 'open-uri'
require 'pry'

module Scraper
  def self.scrape(link)
    all_games = []
    doc = Nokogiri::HTML(open(link))
    games = doc.css('div.product > .product_info').to_a
    games.each do |game|
      game_hash = {}
      game_hash[:title] = game.children.children.children[0].text
      game_hash[:system] = game.children.children.children[1].text
      game_hash[:other_info] = "#{game.children.children.children[2].text} #{game.children.children.children[3].text}"
      all_games << game_hash
    end
    all_games
  end
end

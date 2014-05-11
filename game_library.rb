require_relative 'modules/scraper'

class GameLibrary
  @@search_options = {}
  CONSOLE_MAP = {:ps4 => {:system_path => 'playstation-4', :end_url_chars => '-1dc'},
                 :ps3 => {:system_path => 'playstation-3', :end_url_chars => '-8d'},
                 :xboxone => {:system_path => 'xbox-one', :end_url_chars => '-1e0'},
                 :xbox360 => {:system_path => 'playstation-3', :end_url_chars => '-8d'},
                 :all => {:system_path => '', :end_url_chars => ''}
                }

  include Scraper
  attr_accessor :link

  def initialize(link)
    @link = link
  end

  def self.start
    console_exists = false
    while console_exists == false
      puts "For what console, are you looking for? (Options: PS4, XboxOne, Xbox360, PS3, all)"
      answer = gets.chomp.downcase
      if CONSOLE_MAP.has_key?(:"#{answer}")
        @@search_options = CONSOLE_MAP[:"#{answer}"]
        console_exists = true
      else
        puts "Console does not exist."
        console_exists = false
      end
    end
    @@search_options
  end

  def get_games
    games = Scraper::scrape(link)
    games.each do |game|
      puts "--------------------------------"
      puts "Title: #{game[:title]}"
      puts "Console: #{game[:system]}"
      puts "Other Info: #{game[:other_info]} "
      puts "--------------------------------"
    end
  end

  def get_next_results
    results = {}
    results[:get_results] = true
    results[:result_qty] = 12
    while results[:get_results]
      puts "Would you like to view the next results?(y or n)"
      results[:response] = gets.chomp.downcase
      create_results_link(results)
    end
  end

  def create_results_link(options)
    if options[:response] == 'y'
      results = '2b' + options[:result_qty].to_s
      @link = "http://www.gamestop.com/browse/games/#{@@search_options[:system_path] + '?'}nav=#{results},28-xu0,13ffff2418#{@@search_options[:end_url_chars]}"
      puts "Next Results: "
      get_games
      options[:result_qty] += 12
    elsif options[:response] == 'n'
      options[:get_results] = false
    else
      puts "Invalid input"
    end
  end
end

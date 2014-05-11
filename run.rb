require_relative 'game_library'
require 'pry'

query = GameLibrary.start
link = "http://www.gamestop.com/browse/games/#{query[:system_path] + '?'}nav=28-xu0,13ffff2418#{query[:end_url_chars]}"
games = GameLibrary.new(link)
games.get_games
games.get_next_results

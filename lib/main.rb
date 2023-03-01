require_relative 'connect_four.rb'

game = ConnectFour.new
game.print_game
game.place_marker(game.ai_token, 3)
game.place_marker(game.ai_token, 3)
game.place_marker(game.ai_token, 3)
game.place_marker(game.player_token, 3)
game.place_marker(game.ai_token, 4)
game.place_marker(game.ai_token, 4)
game.place_marker(game.player_token, 4)
game.place_marker(game.ai_token, 5)
game.place_marker(game.player_token, 5)
game.place_marker(game.player_token, 6)
game.check_win
game.print_game

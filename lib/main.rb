require_relative 'connect_four.rb'

game = ConnectFour.new
game.current_player.place_marker(game.board, 3)
game.print_game

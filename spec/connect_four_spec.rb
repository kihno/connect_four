require "./lib/connect_four.rb"

describe ConnectFour do
  describe "#print_game" do
    it "prints the gameboard" do
      game = ConnectFour.new

      $stdout = StringIO.new
      game.print_game
      $stdout.rewind

      expect($stdout.gets).to eql("\n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF  \u25EF \n")
      expect($stdout.gets).to eql("  1  2  3  4  5  6  7\n")
    end
  end

  describe "#place_marker" do
    it "places marker in correct column" do
      game = ConnectFour.new
      game.current_player.place_marker(game.board, 3)

      expect(game.board[5][3]).to eql(" \u{2B24} ")
    end

    it "places marker in correct row if column already has marker" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 3)
      game.player_two.place_marker(game.board, 3)

      expect(game.board[4][3]).to eql(" \u{25CD} ")
    end
  end

  describe "#check_gameover" do
    it "doesn't set gameover if win not acheived" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 0)
      game.player_two.place_marker(game.board, 1)
      game.player_one.place_marker(game.board, 2)
      game.player_two.place_marker(game.board, 3)
      game.player_two.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 5)
      game.player_two.place_marker(game.board, 0)

      expect(game.gameover).to be false
    end

    it "sets gameover if four in a row has been acheived horizontally" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 2)
      game.player_one.place_marker(game.board, 3)
      game.player_one.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 5)
      game.check_gameover

      expect(game.gameover).to be true
    end

    it "sets gameover if four in a row has been acheived vertically" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 3)
      game.player_one.place_marker(game.board, 3)
      game.player_one.place_marker(game.board, 3)
      game.player_one.place_marker(game.board, 3)
      game.check_gameover

      expect(game.gameover).to be true
    end

    it "doesn't return false win if two consecutive columns add up to four in a row" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 3)
      game.player_one.place_marker(game.board, 3)
      game.player_two.place_marker(game.board, 4)
      game.player_two.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 4)
      game.player_two.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 4)
      game.check_gameover

      expect(game.gameover).to be false
    end

    it "sets gameover if four in a row has been acheived diagonally up" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 3)
      game.player_two.place_marker(game.board, 4)
      game.player_one.place_marker(game.board, 4)
      game.player_two.place_marker(game.board, 5)
      game.player_two.place_marker(game.board, 5)
      game.player_one.place_marker(game.board, 5)
      game.player_two.place_marker(game.board, 6)
      game.player_two.place_marker(game.board, 6)
      game.player_two.place_marker(game.board, 6)
      game.player_one.place_marker(game.board, 6)
      game.check_gameover

      expect(game.gameover).to be true
    end

    it "sets gameover if four in a row has been acheived diagonally down" do
      game = ConnectFour.new
      game.player_one.place_marker(game.board, 3)
      game.player_two.place_marker(game.board, 2)
      game.player_one.place_marker(game.board, 2)
      game.player_two.place_marker(game.board, 1)
      game.player_two.place_marker(game.board, 1)
      game.player_one.place_marker(game.board, 1)
      game.player_two.place_marker(game.board, 0)
      game.player_two.place_marker(game.board, 0)
      game.player_two.place_marker(game.board, 0)
      game.player_one.place_marker(game.board, 0)
      game.check_gameover

      expect(game.gameover).to be true
    end

    it "gameover if all spaces are occupied" do
      game = ConnectFour.new
      game.board = [[' \u{25CD} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{25CD} '],
                    [' \u{2B24} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{2B24} '],
                    [' \u{2B24} ', ' \u{25CD} ', ' \u{25CD} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{25CD} '],
                    [' \u{25CD} ', ' \u{2B24} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{25CD} ', ' \u{25CD} ', ' \u{2B24} '],
                    [' \u{25CD} ', ' \u{25CD} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{2B24} ', ' \u{2B24} ', ' \u{25CD} '],
                    [' \u{25CD} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{2B24} ', ' \u{2B24} ', ' \u{25CD} ', ' \u{2B24} ']]
      game.check_gameover

      expect(game.gameover).to be true
    end
  end
end

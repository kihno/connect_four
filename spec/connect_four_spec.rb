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
      game.place_marker(game.player_token, 3)

      expect(game.board[5][2]).to eql(" \u{2B24} ")
    end

    it "places marker in correct row if column already has marker" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 3)
      game.place_marker(game.ai_token, 3)

      expect(game.board[4][2]).to eql(" \u{25CD} ")
    end
  end

  describe "#check_win" do
    it "doesn't set gameover if win not acheived" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 1)
      game.check_win
      game.place_marker(game.ai_token, 2)
      game.check_win
      game.place_marker(game.player_token, 3)
      game.check_win
      game.place_marker(game.ai_token, 4)
      game.check_win
      game.place_marker(game.ai_token, 5)
      game.check_win
      game.place_marker(game.player_token, 6)
      game.check_win
      game.place_marker(game.ai_token, 7)
      game.check_win

      expect(game.gameover).to be false
    end

    it "sets gameover if four in a row has been acheived horizontally" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 3)
      game.place_marker(game.player_token, 4)
      game.place_marker(game.player_token, 5)
      game.place_marker(game.player_token, 6)
      game.check_win

      expect(game.gameover).to be true
    end

    it "sets gameover if four in a row has been acheived vertically" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 3)
      game.place_marker(game.player_token, 3)
      game.place_marker(game.player_token, 3)
      game.place_marker(game.player_token, 3)
      game.check_win

      expect(game.gameover).to be true
    end

    it "doesn't return false win if two consecutive columns add up to four in a row" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 3)
      game.place_marker(game.player_token, 3)
      game.place_marker(game.ai_token, 4)
      game.place_marker(game.ai_token, 4)
      game.place_marker(game.player_token, 4)
      game.place_marker(game.ai_token, 4)
      game.place_marker(game.player_token, 4)
      game.place_marker(game.player_token, 4)
      game.check_win

      expect(game.gameover).to be false
    end

    xit "sets gameover if four in a row has been acheived diagonally up" do
      game = ConnectFour.new
      game.place_marker(game.player_token, 3)
      game.place_marker(game.ai_token, 4)
      game.place_marker(game.player_token, 4)
      game.place_marker(game.ai_token, 5)
      game.place_marker(game.ai_token, 5)
      game.place_marker(game.player_token, 5)
      game.place_marker(game.ai_token, 6)
      game.place_marker(game.ai_token, 6)
      game.place_marker(game.ai_token, 6)
      game.place_marker(game.player_token, 6)
      game.check_win

      expect(game.gameover).to be true
    end

    xit "sets gameover if four in a row has been acheived diagonally down" do
      game = ConnectFour.new
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

      expect(game.gameover).to be true
    end
  end
end

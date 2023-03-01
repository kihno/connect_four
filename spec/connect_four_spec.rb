require "./lib/connect_four.rb"

describe ConnectFour do
  describe "#print_game" do
    it "prints the gameboard" do
      game = ConnectFour.new

      $stdout = StringIO.new
      game.print_game
      $stdout.rewind

      expect($stdout.gets).to eql("\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql(" |   |   |   |   |   |   |   |\n")
      expect($stdout.gets).to eql(" -----------------------------\n")
      expect($stdout.gets).to eql("   1   2   3   4   5   6   7\n")
    end
  end
end

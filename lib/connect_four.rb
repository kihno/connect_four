class ConnectFour
  def initialize
    @board = Array.new(6) {Array.new(7, ' ')}
  end

  def print_game
    puts

    @board.each do |row|
      row_styled = []
      row.each.with_index do |square, index|
        if index == 0
          row_styled << "| #{square} |"
        else
          row_styled << " #{square} |"
        end
      end
      puts " #{row_styled.join}"
      puts " -----------------------------"
    end
    puts '   1   2   3   4   5   6   7'
  end
end

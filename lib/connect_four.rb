class ConnectFour
  attr_reader :player_token, :ai_token, :gameover
  attr_accessor :board

  def initialize
    @empty = " \u{25EF} "
    @board = Array.new(6) { Array.new(7, @empty) }
    @player_token = " \u{2B24} "
    @ai_token = " \u{25CD} "
    @gameover = false
  end

  def print_game
    puts
    @board.each do |row|
      puts " #{row.join}"
    end
    puts '  1  2  3  4  5  6  7'
  end

  def place_marker(marker, column)
    index = column - 1
    @board.reverse_each do |row|
      break row[index] = marker if row[index] == @empty
    end
  end

  def check_win
    # check for horizontal win
    @board.each do |row|
      row.each_cons(4) { |set| @gameover = true if set.uniq.count <= 1 && set[0] != @empty }
    end

    # check for vertical win
    col_index = 0
    until col_index > 6
      column = []
      @board.each do |row|
        row.each.with_index do |space, index|
          column << space if index == col_index
        end
        column.each_cons(4) { |set| @gameover = true if set.uniq.count <= 1 && set[0] != @empty }
      end
      col_index += 1
    end
  end
end

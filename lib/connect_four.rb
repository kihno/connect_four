class ConnectFour
  attr_reader :player_token, :ai_token, :empty
  attr_accessor :board

  def initialize
    @empty = " \u{25EF} "
    @board = Array.new(6) { Array.new(7, @empty) }
    @player_token = " \u{2B24} "
    @ai_token = " \u{25CD} "
  end

  def game_loop
    start_message
    column = validate_location(gets.chomp)
  end

  def start_message
    print_game
    puts 'Choose a column to place a token:'
  end

  def print_game
    puts
    @board.each do |row|
      puts " #{row.join}"
    end
    puts '  1  2  3  4  5  6  7'
  end

  def validate_location(location)
    if location.between?(1..7)
      index = location - 1
      column = []
      @board.each do |row|
        column << row[index] if row[index] == @empty
      end
      if column.empty?
        puts 'That column is full. Please choose another:'
        validate_location(gets.chomp)
      else
        location
      end
    else
      puts 'Please enter a number 1 - 7:'
      validate_location(gets.chomp)
    end
  end

  def place_marker(marker, column)
    index = column - 1
    @board.reverse_each do |row|
      break row[index] = marker if row[index] == @empty
    end
  end

  def horizontal_win?
    @board.each do |row|
      row.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != @empty }
    end
    false
  end

  def vertical_win?
    col_index = 0
    until col_index > 6
      column = []
      @board.each do |row|
        row.each.with_index do |space, index|
          column << space if index == col_index
        end
        column.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != @empty }
      end
      col_index += 1
    end
    false
  end

  def diagonal_win?
    # check for diagonal (up) win
    diag_index = 3
    until diag_index > 8
      offset_index = diag_index
      diag = []
      @board.each do |row|
        row.each.with_index do |space, index|
          diag << space if index == offset_index
        end
        offset_index -= 1
        diag.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != @empty }
      end
      diag_index += 1
    end

    # check for diagonal (down) win
    diag_index = 3
    until diag_index < -2
      offset_index = diag_index
      diag = []
      @board.each do |row|
        row.each.with_index do |space, index|
          diag << space if index == offset_index
        end
        offset_index += 1
        diag.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != @empty }
      end
      diag_index -= 1
    end
    false
  end

  def draw?
    @board.each { |row| return false if row.include?(@empty) }
    true
  end

  def gameover?
    return true if horizontal_win? || vertical_win? || diagonal_win? || draw?

    false
  end
end

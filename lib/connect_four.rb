require_relative './player.rb'
require_relative 'token'

class ConnectFour
  attr_reader :player_one, :player_two, :current_player, :gameover
  attr_accessor :board
  include Token

  def initialize
    @board = Array.new(6) { Array.new(7, EMPTY) }
    @player_one = Player.new('You', SOLID)
    @player_two = Player.new
    @current_player = @player_one
    @gameover = false
  end

  def game_loop
    until @gameover
      start_message
      player_choice = validate_location(gets.chomp)
      @current_player.place_marker(@board, player_choice)
      check_gameover
      toggle_player
      ai_choice = validate_location(rand(1..7))
      @current_player.place_marker(@board, ai_choice)
      print_game
      toggle_player
    end

    replay
  end

  def start_message
    print_game
    puts 'Choose a column to place a token:'
  end

  def replay
    puts 'Do you want to play again? [y/n]'
    answer = gets.chomp.downcase

    if answer == 'y'
      start
    else
      game_loop
    end
  end

  def print_game
    puts
    @board.each do |row|
      puts " #{row.join}"
    end
    puts '  1  2  3  4  5  6  7'
  end

  def validate_location(location)
    index = location.to_i - 1
    if index.to_i.between?(0, 6)
      column = []
      @board.each do |row|
        column << row[index] if row[index] == EMPTY
      end
      if column.empty?
        validate_location(rand(1..7)) if @current_player == @player_two

        puts 'That column is full. Please choose another:'
        validate_location(gets.chomp)
      else
        index
      end
    else
      puts 'Please enter a number 1 - 7:'
      validate_location(gets.chomp)
    end
  end

  def toggle_player
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  # def place_marker(marker, column)
  #   index = column - 1
  #   @board.reverse_each do |row|
  #     break row[index] = marker if row[index] == EMPTY
  #   end
  # end

  def horizontal_win?
    @board.each do |row|
      row.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != EMPTY }
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
        column.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != EMPTY }
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
        diag.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != EMPTY }
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
        diag.each_cons(4) { |set| return true if set.uniq.count == 1 && set[0] != EMPTY }
      end
      diag_index -= 1
    end
    false
  end

  def draw?
    @board.each { |row| return false if row.include?(EMPTY) }
    true
  end

  def check_gameover
    if draw?
      @gameover = true
      puts 'The game has ended in a draw.'
    elsif horizontal_win? || vertical_win? || diagonal_win?
      @gameover = true
      puts "#{@current_player} won the game."
    end
  end
end

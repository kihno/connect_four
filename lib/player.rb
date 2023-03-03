require_relative 'token'

class Player
  attr_accessor :name, :token
  include Token
  
  def initialize(name = 'The Computer', token = STRIPE)
    @name = name
    @token = token
  end

  def place_marker(board, index)
    board.reverse_each do |row|
      break row[index] = @token if row[index] == EMPTY
    end
  end
end

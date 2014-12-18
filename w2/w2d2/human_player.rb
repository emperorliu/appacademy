require_relative "no_move_error.rb"

class HumanPlayer

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn
    puts "Please enter your move."
    move = gets.chomp
    arr = move.split(",").map { |s| s.strip.split("").map(&:to_i) }
    raise NoMoveError.new "That isn't a move" if move.length != 6
    arr
  end

end

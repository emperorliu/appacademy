require_relative "no_move_error.rb"
require 'byebug'

class HumanPlayer
  LETTERS_TO_NUM = ("a".."h").to_a

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    puts "Please enter your move."
    move = gets.chomp
    raise NoMoveError.new("That isn't a move") unless valid_input?(move)
    arr = move.split(",").map! { |s| s.strip.split("") }

    arr.map { |y, x| [x.to_i - 1, LETTERS_TO_NUM.index(y)] }
  end

  def valid_input?(str)
    chrs = str.strip.split("")
    if chrs.length != 6
      false
    elsif chrs[2] != ","
      false
    elsif !LETTERS_TO_NUM.include?(chrs[0]) || !LETTERS_TO_NUM.include?(chrs[4])
      false
    elsif chrs[1].to_i.zero? || chrs[5].to_i.zero?
      false
    elsif chrs[1].to_i > 8 || chrs[5].to_i > 8
      false
    else
      true
    end

    # chrs.length == 6 &&
    # chrs[2] != "," &&
    # LETTERS_TO_NUM.include?(chrs[0]) &&
    # LETTERS_TO_NUM.include?(chrs[4]) &&
    # !chrs[1].to_i.zero? &&
    # !chrs[5].to_i.zero? &&
    # !chrs[1].to_i > 8 &&
    # chrs[5].to_i > 8
  end
end

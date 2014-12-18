require_relative 'sliding_piece.rb'

class Rook < SlidingPiece

  attr_accessor :pos
  attr_reader :board, :color, :symbol

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2656" : "\u265C" )
  end

  def move_dirs
    ORTHOGONALS
  end
end

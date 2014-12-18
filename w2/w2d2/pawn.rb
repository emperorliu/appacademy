require_relative 'piece.rb'

class Pawn < Piece

  attr_accessor :pos
  attr_reader :board, :color, :symbol

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = ( color == :black ? "\u2659" : "\u265F" )
  end

  def moves
    dy = ( color == :black ? 1 : -1 )
    x, y = pos
    forward_moves = [[x + dy, y], [x + dy * 2, y]].select do |move|
      check_board_at(move) == :nil
    end
    diagonal_moves = [[x + dy, y - 1], [x + dy, y + 1]].select do |move|
      check_board_at(move) == :opponent
    end
    (forward_moves + diagonal_moves).reject { |move| off_board?(move) }
  end

end

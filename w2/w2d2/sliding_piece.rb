require_relative 'piece.rb'

class SlidingPiece < Piece
  DIAGONALS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  ORTHOGONALS = [[0, 1], [1, 0], [-1, 0], [0, -1]]

  attr_accessor :pos
  attr_reader :board, :color

  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def moves
    total_moves = []
    x, y = pos
    move_dirs.each do |dir|
      i, j = dir
      x2, y2 = [x + i, y + j]
      until off_board?([x2, y2])
        case check_board_at([x2, y2])
        when :nil
          total_moves << [x2, y2]
          x2 += i
          y2 += j
        when :opponent
          total_moves << [x2, y2]
          break
        when :ally
          break
        end
      end
    end
    total_moves
  end

  def move_dirs
  end
end

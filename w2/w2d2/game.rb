require_relative 'board.rb'
require_relative 'no_move_error.rb'
require_relative 'human_player.rb'

class Game

  attr_reader :board, :white_player, :black_player

  def initialize(white, black)
    @board = Board.new
    @white_player = white
    @black_player = black
  end

  def play
    player = white_player
    until board.checkmate?(player.color)
      begin
        board.render_board
        start, end_pos = player.play_turn
        board.move(start, end_pos, player.color)
        player = flip_turns(player)
      rescue NoMoveError => e
        p e.message
        retry
      end
    end
    board.render_board
    print "Game over! You win, #{flip_turns(player).name}"
  end

  def flip_turns(player)
    player == white_player ? black_player : white_player
  end

end


game = Game.new(HumanPlayer.new("1", :white), HumanPlayer.new("2", :black))
game.play

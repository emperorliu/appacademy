require_relative 'board'
require_relative 'players'

class Game
  attr_accessor :board
  attr_accessor :player1, :player2, :marks

  def initialize(size, player1, player2)
    @board = Board.new(size)
    @player1 = player1
    @player2 = player2
    player1.size = size if player1.class == ComputerPlayer
    player2.size = size if player2.class == ComputerPlayer
    @marks = ['x', 'o']
    @won = nil
  end

  def play
    until won? || board.full?
      board.display
      [player1, player2].each_with_index do |player, i|
        move = play_turn(player)
        board[*move] = marks[i]
        @won = won?
        break if board.full?
      end
    end
    board.display

    if won?.nil?
      puts "it's a tie :/"
    else
      winner = ( @won == 'x' ? player1 : player2 )
      puts "#{winner.name} won!"
    end
  end

  def play_turn(player)
    pos = player.move
    until board.empty_at?(pos)
      p "Invalid move, try again." if player.class == HumanPlayer
      pos = player.move
    end

    pos
  end

  def won?
    board.grid.each do |row|
      return "x" if row.all? { |x| x == "x" }
      return "o" if row.all? { |x| x == "o" }
    end

    board.grid.transpose.each do |row|
      return "x" if row.all? { |x| x == "x" }
      return "o" if row.all? { |x| x == "o" }
    end

    return "x" if (0..2).all? { |i| board[i, i] == "x" }
    return "o" if (0..2).all? { |i| board[i, i] == "o" }

    return "x" if (0..2).all? { |i| board[i, 2 - i] == "x" }
    return "o" if (0..2).all? { |i| board[i, 2 - i] == "o" }

    nil
  end
end


player1 = HumanPlayer.new("Human")
player2 = ComputerPlayer.new
game = Game.new(4, player1, player2)
game.play

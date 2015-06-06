require_relative 'board'
require_relative 'players'

class Game
  attr_accessor :board
  attr_reader :size, :player_x, :player_o

  def initialize(options)
    @size = options[:size] || 3
    @board = Board.new(size: size)
    @player_x = setup_player(options[:x], 'x')
    @player_o = setup_player(options[:o], 'o')
    @won = nil
  end

  def setup_player(type, mark)
    if type == :human
      puts "what's your name, player `#{mark}`?"
      player = HumanPlayer.new(name: gets.chomp, mark: mark)
    else
      player = ComputerPlayer.new(size: size, mark: mark)
    end

    player
  end


  def play
    board.display
    until won? || board.full?
      [player_x, player_o].each_with_index do |player, i|
        move = play_turn(player)
        board[*move] = player.mark
        @won = won?
        break if board.full? || @won
        board.display
      end
    end
    board.display

    if won?.nil?
      puts "it's a tie :/"
    else
      winner = ( @won == 'x' ? player_x : player_o )
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

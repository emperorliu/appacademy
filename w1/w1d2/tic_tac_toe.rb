require 'colorize'


class Game
  attr_accessor :board
  attr_accessor :player1, :player2, :marks

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
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


class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move
    puts "Make a move."
    gets.chomp.split(', ').map(&:to_i)
  end
end

class ComputerPlayer
  attr_reader :name, :size

  def initialize(size = 3)
    @size = size
    @name = "#{rand(100...1000)}-c0Mpv73r"
  end

  def move
    [rand(0...size), rand(0...size)]
  end
end


class Board
  attr_reader :grid, :size

  def initialize(size = 3)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
  end

  def render
    grid.map do |row|
      "\u2551 " + row.map do |i|
        i.nil? ? " " : i.colorize(:yellow)
      end.join(" \u2551 ") + " \u2551"
    end.join("\n\u2560" + "\u2550" * size + \
              ("\u256C" + "\u2550" * size) * (size - 1) + "\u2563\n")
  end

  def display
    puts "\e[H\e[2J"
    puts "\u2554" + "\u2550" * size + \
        ("\u2566" + "\u2550" * size) * (size - 1) + "\u2557"
    puts render
    puts "\u255A" + "\u2550" * size + \
        ("\u2569" + "\u2550" * size) * (size - 1) + "\u255D"
  end

  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, val)
    @grid[x][y] = val
  end

  def full?
    grid.flatten.compact.length == 9
  end

  def empty_at?(pos)
    self[*pos].nil?
  end

  def place_mark(pos, mark)
    self[*pos] = mark
  end
end

player1 = HumanPlayer.new("Human")
player2 = ComputerPlayer.new
game = Game.new(player1, player2)
game.play

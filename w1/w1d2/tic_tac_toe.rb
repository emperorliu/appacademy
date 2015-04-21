require 'colorize'

class Game

  attr_accessor :board, :p1, :p2, :marks

  def initialize(p1, p2)
    @board = Board.new
    @p1 = p1
    @p2 = p2
    @marks = ['x', 'o']
    board.display
  end

  def play
    until board.won?
      [p1, p2].each_with_index do |player, i|
        puts "Make a move." if player.class == HumanPlayer
        player_move = player.move
        until board.empty?(player_move)
          p "Invalid move, try again." if player.class == HumanPlayer
          player_move = player.move
        end
        board.place_mark(player_move, marks[i])
        board.display
        break if board.won?
      end
    end
    if board.winner == 'x'
      puts "#{p1.name} won!"
    else
      puts "#{p2.name} won!"
    end
  end
end


class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move
    gets.chomp.split(' ').map(&:to_i)
  end
end

class ComputerPlayer
  attr_reader :name

  def initialize
    @name = "#{rand(10..100)}-c0Mpv73r"
  end

  def move
    [rand(0..2), rand(0..2)]
  end
end


class Board
  attr_reader :board, :mark
  attr_accessor :winner

  def initialize
    @board = Array.new(3) { Array.new(3) }
    @winner = ""
  end

  def render
    board.map do |row|
      "\u2551 " + row.map do |i|
        i.nil? ? " " : i.colorize(:yellow)
      end.join(" \u2551 ") + " \u2551"
    end.join("\n\u2560" + "\u2550" * 3 + \
               "\u256C" + "\u2550" * 3 + \
               "\u256C" + "\u2550" * 3 + "\u2563\n")
  end

  def display
    puts "\e[H\e[2J"
    puts "\u2554" + "\u2550" * 3 + \
         "\u2566" + "\u2550" * 3 + \
         "\u2566" + "\u2550" * 3 + "\u2557"
    puts render
    puts "\u255A" + "\u2550" * 3 + \
         "\u2569" + "\u2550" * 3 + \
         "\u2569" + "\u2550" * 3 + "\u255D"
  end

  def won?
    mark = ""
    board.each_with_index do |row, i|
      if row.all? { |x| x == 'x' }
        self.winner = row[0]
        return true
      elsif row.all? { |x| x == 'o' }
        self.winner = row[0]
        return true
      end
    end
    board.transpose.each_with_index do |row, i|
      if row.all? { |x| x == 'x' }
        self.winner = row[0]

        return true
      elsif row.all? { |x| x == 'o' }
        self.winner = row[0]

        return true
      end
    end
    if board[0][0] && board[0][0] == board[1][1] &&
                      board[1][1] == board[2][2]
      self.winner = board[0][0]

      true
    elsif board[2][0] && board[2][0] == board[1][1] &&
                         board[1][1] == board[0][2]
      self.winner = board[2][0]

      true
    else
      false
    end
  end

  def empty?(pos)
    x, y = pos
    board[x][y].nil?
  end

  def place_mark(pos, mark)
    if empty?(pos)
      x, y = pos
      board[x][y] = mark
    else
      "Not empty!"
    end
  end
end

p1 = HumanPlayer.new("Human")
p2 = ComputerPlayer.new
game = Game.new(p1, p2)
game.play

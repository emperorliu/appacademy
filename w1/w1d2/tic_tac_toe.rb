class Game
  attr_accessor :board, :p1, :p2, :marks

  def initialize(p1, p2)
    @board = Board.new
    @p1 = p1
    @p2 = p2
    @marks = ['X', 'O']
    board.render
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
        board.render
        break if board.won?
      end
    end
    if board.winner == 'X'
      puts "#{p1.name} won!"
    else
      puts "#{p2.name} won!"
    end
  end
end


class HumanPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def move
    gets.chomp.split(' ').map(&:to_i)
  end
end

class ComputerPlayer
  attr_accessor :name

  def initialize
    @name = "#{rand(1..100)}-computer"
  end

  def move
    # if board[1][1].nil?
      # [1, 1]
    # else
      [rand(0..2), rand(0..2)]
    # end
  end

  # def move(game, mark)
  #   winner_move(game, mark) || random_move(game)
  # end
  #
  # private
  # def winner_move(game, mark)
  #   (0..2).each do |x|
  #     (0..2).each do |y|
  #       board = game.board.dup
  #       pos = [x, y]
  #
  #       next unless board.empty?(pos)
  #       board[pos] = mark
  #
  #       return pos if board.winner == mark
  #     end
  #   end
  #
  #   # no winning move
  #   nil
  # end
  #
  # def random_move(game)
  #   board = game.board
  #   while true
  #     range = (0..2).to_a
  #     pos = [range.sample, range.sample]
  #
  #     return pos if board.empty?(pos)
  #   end
  # end
end


class Board
  attr_reader :board, :mark
  attr_accessor :winner

  def initialize
    @board = Array.new(3) { Array.new(3) }
    @winner = ""
  end

  def render
    puts board.map { |row| row.join("\t") }.join("\n")
  end

  def won?
    mark = ""
    board.each_with_index do |row, i|
      if row.all? { |x| x == 'X' }
        self.winner = row[0]
        return true
      elsif row.all? { |x| x == 'O' }
        self.winner = row[0]
        return true
      end
    end
    board.transpose.each_with_index do |row, i|
      if row.all? { |x| x == 'X' }
        self.winner = row[0]
        return true
      elsif row.all? { |x| x == 'O' }
        self.winner = row[0]
        return true
      end
    end
    if board[0][0] && board[0][0] == board[1][1] && board[1][1] == board[2][2]
      self.winner = board[0][0]
      return true
    elsif board[2][0] && board[2][0] == board[1][1] && board[1][1] == board[0][2]
      self.winner = board[2][0]
      return true
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

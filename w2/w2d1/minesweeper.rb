require 'yaml'

BOARD_SIZE = 9
class Minesweeper

  attr_accessor :board, :num_mines

  def initialize
    build_board
    rand_mines
    render_board
  end

  def rand_mines
    @num_mines = 10
    mine_locations = []
    num_mines.times do
      x = rand(BOARD_SIZE)
      y = rand(BOARD_SIZE)
      while mine_locations.include?([x, y])
        x = rand(BOARD_SIZE)
        y = rand(BOARD_SIZE)
      end
      mine_locations << [x,y]
    end
    mine_locations.each do |(i,j)|
      target_node = board[i][j]
      target_node.value = "X"
      target_node.avail_neighbors.each do |neighbor|
        x2, y2 = neighbor.position
        board[x2][y2].value += 1 if board[x2][y2].value.class == Fixnum
      end
    end
  end

  def reveal(pos)
    x, y = pos
    node = board[x][y]

    if node.value != "X" || node.flagged !="F"
      if node.value == 0
        reveal_neighbors(pos)
      end
    end
    node.visible = true
  end

  def reveal_neighbors(pos)
    x, y = pos
    node = board[x][y]
    neighbors = node.avail_neighbors
    neighbors.reject! { |i| i.value == "X" || i.flagged == "F" || i.visible }
    if neighbors.empty? || neighbors.none? { |i| i.value == 0 }
      neighbors.each do |neighbor|
        neighbor.visible = true
        return
      end
    else
      neighbors.each do |neighbor|
        neighbor.visible = true
        if neighbor.value == 0
          reveal_neighbors(neighbor.position)
        end
      end
    end
  end

  def ended?
    not_visible = 0
    board.each do |row|
      row.each do |node|
        if node.value == "X" && node.visible
          p "You lose!"
          return true
        end
        not_visible += 1 unless node.visible
      end
    end
    if not_visible == num_mines
      p "You win!"
      return true
    end
    false
  end

  def play
    load_game

    until ended?
      render_board
      get_user_input
    end
    render_board
  end

  def load_game
    puts "Start new game (n) or continue old game(o)?"
    answer = gets.chomp
    if answer == "o"
      saved = File.open("minesweeper.yml")
      self.board = YAML::load(saved)
    end
  end

  def get_user_input

    puts "Enter flag(f), reveal(r) or save game(s):"
    choice = gets.chomp

    if choice == "s"
      save
      p "Game saved to minesweeper.yml"
      return
    end

    puts "Enter position to target:"
    x, y = gets.chomp.split(" ").map(&:to_i)
    if x < 0 || x >= BOARD_SIZE || y < 0 || y >= BOARD_SIZE
      get_user_input
    elsif choice == "f"
      flag([x,y])
    elsif choice == "r"
      reveal([x,y])
    else
      get_user_input
    end
  end

  def save
    File.open("minesweeper.yml", "w") do |f|
      f.puts board.to_yaml
    end
  end

  def build_board
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    BOARD_SIZE.times do |i|
      BOARD_SIZE.times do |j|
        board[i][j] = Node.new([i, j], self)
      end
    end
  end

  def render_board
    puts "   |  " + (0..BOARD_SIZE - 1).to_a.join("  ")
    puts "---+---------------------------"

    BOARD_SIZE.times do |y|
      row_string = "#{y}  |  "
      BOARD_SIZE.times do |x|
        node = board[x][y]
        if node.visible
          row_string << "#{node.value}  "
        else
          row_string << "#{node.flagged}  "
        end
      end
      puts row_string
    end
  end

  def flag(pos)
    x, y = pos
    if board[x][y].flagged == "F"
      board[x][y].flagged = "_"
    else
      board[x][y].flagged = "F" unless board[x][y].visible
    end
  end

end

class Node

  attr_reader :position
  attr_accessor :flagged, :value, :visible

  def initialize(position, game, value=0, flagged="_", visible=false)
    @game = game
    @value, @position, @flagged = value, position, flagged
    @visible = visible
  end

  def get_neighbors
    neighbor_positions = [[1, 0], [1, 1], [0, 1], [-1, 1],
                          [-1, 0], [-1, -1], [0, -1], [1, -1]]
    x, y = position
    neighbor_positions.map { |i, j| [x + i, y + j] }
  end

  def avail_neighbors
    avail_pos = get_neighbors.select do |node|
      i, j = node
      i >= 0 && i < BOARD_SIZE && j >= 0 && j < BOARD_SIZE
    end
    avail_pos.map { |i, j| @game.board[i][j] }
  end
end

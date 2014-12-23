require 'yaml'


class Tile
  DELTAS = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]

  attr_reader :pos

  def initialize(board, pos)
    @board, @pos = board, pos
    @bombed, @explored, @flagged = false, false, false
  end

  def bombed?
    @bombed
  end

  def explored?
    @explored
  end

  def flagged?
    @flagged
  end

  def adjacent_bomb_count
    neighbors.select(&:bombed?).count
  end

  def neighbors
    x, y = pos
    adjacent_pos = DELTAS.map { |i, j| [x + i, y + j] }
    adjacent_pos.select! do |i, j|
      i >= 0 && i < @board.grid_size && j >= 0 && j < @board.grid_size
    end

    adjacent_pos.map { |pos| @board[pos] }
  end

  def plant_bomb
    @bombed = true
  end

  def render
    if flagged?
      "F"
    elsif explored?
      adjacent_bomb_count == 0 ? "_  " : adjacent_bomb_count.to_s + "  "
    else
      "*  "
    end
  end

  def reveal
    if flagged?
      bombed? ? "F" : "f"
    elsif bombed?
      explored? ? "X" : "B"
    else
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    end
  end

  def toggle_flag
    return if @explored

    @flagged = !@flagged
  end

  def explore
    return self if flagged? || explored?

    @explored = true
    if !bombed? && adjacent_bomb_count == 0
      neighbors.each { |tile| tile.explore }
    end

    self
  end
end


class Board
  attr_reader :grid_size, :num_bombs

  def initialize(grid_size, num_bombs)
    @grid_size, @num_bombs = grid_size, num_bombs

    generate_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bombed? && tile.explored? }
  end

  def render(reveal = false)
    @grid.map do |row|
      row.map do |tile|
        reveal ? tile.reveal : tile.render
      end.join("")
    end.join("\n")
  end

  def reveal
    render(true)
  end

  def won?
    @grid.flatten.none? { |tile| tile.bombed? != tile.flagged? }
  end

  private
  def generate_board
    @grid = Array.new(@grid_size) do |row|
      Array.new(@grid_size) { |col| Tile.new(self, [row, col]) }
    end

    plant_bombs
  end

  def plant_bombs
    total_bombs = 0
    while total_bombs < @num_bombs
      rand_pos = Array.new(2) { rand(@grid_size) }

      tile = self[rand_pos]
      next if tile.bombed?

      tile.plant_bomb
      total_bombs += 1
    end

    nil
  end
end

class MinesweeperGame
  LAYOUTS = {
    :small => { :grid_size => 9, :num_bombs => 10 },
    :medium => { :grid_size => 16, :num_bombs => 40 },
    :large => { :grid_size => 32, :num_bombs => 160 }
  }

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])
  end

  def play
    until @board.won? || @board.lost?
      puts @board.render

      action, pos = get_move
      perform_move(action, pos)
    end

    if @board.won?
      puts "You win!"
    elsif @board.lost?
      puts "**Bomb hit!**"
      puts @board.reveal
    end
  end

  private
  def get_move
    action_type, row_s, col_s = gets.chomp.split(",")

    [action_type, [row_s.to_i, col_s.to_i]]
  end

  def perform_move(action_type, pos)
    tile = @board[pos]

    case action_type
    when "f"
      tile.toggle_flag
    when "e"
      tile.explore
    when "s"
      save
    end
  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end
end


MinesweeperGame.new(:small).play

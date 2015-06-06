require 'colorize'

class Board
  attr_reader :grid, :size

  def initialize(options = {})
    @size = options[:size] || 3
    @grid = Array.new(size) { Array.new(size) }
  end

  def display_grid
    hline = "\u2550" * 3
    grid.map do |row|
      "\u2551 " + row.map do |i|
        i.nil? ? " " : i.colorize(:yellow)
      end.join(" \u2551 ") + " \u2551"
    end.join("\n\u2560" + hline + ("\u256C" + hline) * (size - 1) + "\u2563\n")
  end

  def display
    hline = "\u2550" * 3
    puts "\e[H\e[2J"
    puts "\u2554" + hline + ("\u2566" + hline) * (size - 1) + "\u2557"
    puts display_grid
    puts "\u255A" + hline + ("\u2569" + hline) * (size - 1) + "\u255D"
  end

  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, val)
    @grid[x][y] = val
  end

  def full?
    grid.flatten.compact.length == size ** 2
  end

  def empty_at?(pos)
    self[*pos].nil?
  end

  def place_mark(pos, mark)
    self[*pos] = mark
  end
end

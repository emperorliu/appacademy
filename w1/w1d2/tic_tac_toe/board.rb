require 'colorize'

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
    end.join("\n\u2560" + "\u2550" * 3 + \
              ("\u256C" + "\u2550" * 3) * (size - 1) + "\u2563\n")
  end

  def display
    puts "\e[H\e[2J"
    puts "\u2554" + "\u2550" * 3 + \
        ("\u2566" + "\u2550" * 3) * (size - 1) + "\u2557"
    puts render
    puts "\u255A" + "\u2550" * 3 + \
        ("\u2569" + "\u2550" * 3) * (size - 1) + "\u255D"
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

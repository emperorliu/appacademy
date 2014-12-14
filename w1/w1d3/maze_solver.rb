#!/usr/bin/env ruby

class MazeSolver

  attr_reader :maze, :from, :to
  attr_accessor :solution, :current_position

  def initialize(filename)
    load_file(filename)
    @solution = copy(maze)
  end

  def load_file(filename)
    lines = File.readlines("#{filename}").map(&:chomp)
    @maze = [].tap { |maze| lines.each { |l| maze << l.split("") }}
  end

  def solve
    @from = find_start
    @to = find_end
    @current_position = from.dup

    find_path(current_position, copy(solution))

    solution.each { |row| puts row }
  end

  def find_path(pos, path)
    if done?(pos, path)
      path.each { |i| puts i.join }
      return path
    end
    return path unless can_move?(pos, path)
    new_pos = pos
    if new_position = move_right(pos, path)
      find_path(new_position, copy(path))
    end
    if new_position = move_up(pos, path)
      find_path(new_position, copy(path))
    end
    if new_position = move_left(pos, path)
      find_path(new_position, copy(path))
    end
    if new_position = move_down(pos, path)
      find_path(new_position, copy(path))
    end

  end

  def can_move?(pos, path)
    x, y = pos
    ![path[x+1][y], path[x-1][y], path[x][y+1], path[x][y-1]].include?(" ")
  end

  def done?(pos, path)
    x, y = pos
    [path[x+1][y], path[x-1][y], path[x][y+1], path[x][y-1]].include?("E")
  end

  def copy(array)
    array.map {|row| row.dup}
  end

  def move_right(pos, path)
    x, y = pos
    destination = [x, y + 1]
    if valid?(destination)
      path[x][y + 1] = "X"
      return destination
    end
    false
  end

  def move_left(pos, path)
    x, y = pos
    destination = [x, y - 1]
    if valid?(destination)
      path[x][y - 1] = "X"
      return destination
    end
    false
  end

  def move_up(pos, path)
    x, y = pos
    destination = [x - 1, y]
    if valid?(destination)
      path[x - 1][y] = "X"
      return destination
    end
    false
  end

  def move_down(pos, path)
    x, y = pos
    destination = [x + 1, y]
    if valid?(destination)
      path[x + 1][y] = "X"
      return destination
    end
    false
  end

  def valid?(pos)
    x, y = pos
    !["X", "*", "E", "S"].include?(solution[x][y])
  end

  def find_start
    maze.each_index do |i|
      maze[i].each_index do |j|
        return [i, j] if maze[i][j] == "S"
      end
    end
  end

  def find_end
    maze.each_index do |i|
      maze[i].each_index do |j|
        return [i, j] if maze[i][j] == "E"
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  name = ARGV[0]
  solver = MazeSolver.new(name)
  f = File.open("#{name}-solved", "w")
  f.puts solver.solve
  f.close
end

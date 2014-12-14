require_relative '00_tree_node'

class KnightPathFinder

  attr_reader :start_pos, :visited_positions, :move_tree

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    build_move_tree
  end

  def find_path(end_pos)
    path = []
    node = move_tree.bfs(end_pos)
    return start_pos if node.nil?
    until node.parent.nil?
      path << node.value
      node = node.parent
    end
    path.reverse.unshift(start_pos)
  end


  def build_move_tree
    @move_tree = PolyTreeNode.new(start_pos)
    queue = [move_tree]
    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |pos|
        child = PolyTreeNode.new(pos)
        current_node.add_child(child)
        queue << child
      end
    end
  end

  def new_move_positions(pos)
    available_pos = KnightPathFinder.valid_moves(pos)
    available_pos -= visited_positions
    @visited_positions += available_pos
    available_pos
  end

  private

  def self.valid_moves(pos)
    all_moves = moves_for(pos)
    all_moves.select { |m| m.none? { |i| i < 0 or i > 7 } }
  end

  def self.moves_for(pos)
    x, y = pos
    arr = [[-2, -1], [-2,  1],
           [-1, -2], [-1,  2],
           [ 1, -2], [ 1,  2],
           [ 2, -1], [ 2,  1]]
    arr.map! {|a, b| [a + x, b + y]}
  end



end

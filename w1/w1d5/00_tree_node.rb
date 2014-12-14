class PolyTreeNode
  attr_accessor :value, :parent
  attr_reader :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    parent.children.delete(self) unless parent.nil?
    @parent = node
    unless parent.nil? or self.parent.children.include?(self)
      node.children << self
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Bad parent=!" unless child.parent == self
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      node = child.dfs(target_value)
      return node if node
    end
    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      if node.value == target_value
        return node
      else
        queue += node.children
      end
    end
    nil
  end

end


node1 = PolyTreeNode.new('root')
node2 = PolyTreeNode.new('child1')
node3 = PolyTreeNode.new('child2')

node2.parent = node1

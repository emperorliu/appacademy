require 'pry'

class MyHashSet

  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store[el] == true
  end

  def delete(el)
    if include?(el)
      @store.delete(el)
      return true
    else
      return false
    end
  end

  def to_a
    @store.keys
  end

  def union(set2)
    union = @store.to_a
    set2.to_a.each do |i|
      union << i unless @store[i]
    end
    new_set = MyHashSet.new
    union.each { |i| new_set.insert(i) }
    new_set
  end

  def intersect(set2)
    intersection = []
    set2.to_a.each do |i|
      intersection << i if @store[i]
    end
    new_set = MyHashSet.new
    intersection.each { |i| new_set.insert(i) }
    new_set
  end

  def minus(set2)
    intersection = intersect(set2)
    new_set = @store.dup
    intersection.to_a.each { |i| new_set.delete(i) }
    new_set
  end

end

binding.pry

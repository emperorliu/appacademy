def multiply_by_two arr
  arr.map { |i| 2 * i }
end

class Array

  def my_each &block
    i = 0
    while i < length
      block.call self[i]
      i += 1
    end

    self
  end
end

def median arr
  len = arr.length
  if len.even?
    (arr.sort[len / 2 - 1] + arr.sort[len / 2]) / 2.0
  else
    arr.sort[len / 2]
  end
end

def concatenate arr
  arr.inject('') { |a, e| a + e + ' ' }.strip
end

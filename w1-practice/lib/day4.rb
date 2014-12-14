class Array

  def my_each(&prc)
    return self unless block_given?
    i = 0
    while i < length
      prc[ self[i] ]
      i += 1
    end
    self
  end

  def my_map(&blk)
  end

  def my_select(&blk)
  end

  def my_inject(&blk)
  end

  def my_sort!(&blk)
  end

  def my_sort(&blk)
  end
end


def eval_block(*args, &blk)
end


# Example calls to eval_block

# eval_block("Kerry", "Washington", 23) do |fname, lname, score|
#   puts "#{lname}, #{fname} won #{score} votes."
# end
# Washington, Kerry won 23 votes.
# => nil


def deep_dup(arr)
end


def fib_rec(num)
end

def binary_search(arr, n)
end


def make_change1(n, change)
end


def make_change2(n, change)
end


def merge_sort(arr)
end

def merge(arr1, arr2)
end

class Array
  def subsets
  end
end



def sum_recur arr
  return 0 if arr.empty?
  arr.pop + sum_recur(arr)
end

def includes?(arr, target)
  return false if arr.empty?
  return true if arr.pop == target
  includes?(arr, target)
end

def num_occur(arr, target)
  return 0 if arr.empty?
  count = 0
  count += 1 if arr.pop == target
  count += num_occur(arr, target)
  count
end

def add_to_twelve? arr
  return false if arr.length < 2
  return true if arr[0] + arr[1] == 12
  add_to_twelve? arr.drop(1)
end


def reverse n
  return n if n.to_s.length < 2
  s = n.to_s.split("")
  [s.pop, reverse(s.join.to_i)].join.to_i
end

def sorted? arr

end

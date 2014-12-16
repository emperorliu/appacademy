def range(from, to)
  arr = []
  if to < from
    []
  elsif from == to
    arr << to
  else
    arr += [from] + [range(from + 1, to)]
  end
  arr.flatten
end

def my_sum_it(arr)
  arr.inject(&:+)
end

def my_sum_rec(arr)
  sum = arr.pop
  if arr.length < 1
    arr.pop
  else
    sum += my_sum_rec(arr)
  end
  sum
end

def exp(base, exp)
  return 1 if exp == 0
  base * exp(base, exp - 1)
end

def exp2(base, exp)
  if exp == 0
    1
  elsif exp == 1
    base
  else
    if exp.even?
      exp2(base, exp / 2) * exp2(base, exp / 2)
    else
      base * exp2(base, (exp - 1) / 2) * exp2(base, (exp - 1) / 2)
    end
  end
end

def deep_dup(arr)

  unless arr.is_a? Array
    arr.dup
  else
    new_arr = []
    arr.each do |i|
      new_arr << deep_dup(i)
    end
    new_arr
  end
end

def fib_iter(num)
  return [] if num == 0
  new_arr = []
  (1..num).to_a.each do |i|
    if i == 1 or i == 2
      new_arr << 1
    else
      new_arr << new_arr[-2] + new_arr[-1]
    end
  end
  new_arr
end

def fib_rec(num)
  return [] if num == 0
  new_arr = []
  if num == 1 or num == 2
    new_arr << 1
  else
    child_arr = fib_rec(num - 1)
    new_arr = child_arr
    new_arr << child_arr[-2] + child_arr[-1]
  end
  new_arr
end

def binary_search(arr, n)
  pivot = arr.length / 2

  if arr[pivot] == n
    return pivot
  elsif arr[pivot] > n
    pivot = binary_search(arr.take(pivot), n)
  else
    pivot += 1 + binary_search(arr.drop(pivot + 1), n)
  end
  pivot
end

# PART ONE OF MAKE CHANGE
def make_change1(n, change)
  change_array = []
  largest_coin = 0

  change.sort.reverse.each do |coin|
    if n >= coin
      largest_coin = coin
      break
    end
  end

  return [largest_coin] if largest_coin == n
  change_array += [largest_coin] + make_change(n - largest_coin, change)
end


def make_change2(n, change)
  return [] if change.empty?
  change = change.sort.reverse
  coin = change.first

  if n >= coin
    [coin] + make_change1(n - coin, change)
  else
    make_change1(n, change.drop(1))
  end
end

def make_change3(n, change)
  change_options = []
  return [] if change.empty?
  change.sort.reverse
  while change.any?
    coin = change.first
    if n >= coin
      change_options << [coin] + make_change1(n - coin, change)
    else
      change_options << make_change1(n, change.drop(1))
    end
      change = change.drop(1)
  end
  change_options.sort_by(&:length)[0]
end


def merge_sort(arr)
  pivot = arr.length / 2
  left = arr.take(pivot)
  right = arr.drop(pivot)

  return arr if arr.length < 2

  merge(merge_sort(left), merge_sort(right))
end

def merge(arr1, arr2)
  new_arr = []
  len = [arr1, arr2].max
  while arr1.any? and arr2.any?
    if arr1[0] > arr2[0]
      new_arr << arr2[0]
      arr2 = arr2.drop(1)
    else
      new_arr << arr1[0]
      arr1 = arr1.drop(1)
    end
  end

  until arr1.empty?
    new_arr << arr1[0]
    arr1 = arr1.drop(1)
  end
  until arr2.empty?
    new_arr << arr2[0]
    arr2 = arr2.drop(1)
  end
  new_arr
end

def subsets_(arr)
  result = []
  (0..arr.length).each do |i|
    result << arr.combination(i).to_a
  end
  result.flatten(1)
end

class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end
end

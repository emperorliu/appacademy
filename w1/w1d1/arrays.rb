class Array

  def my_uniq
    new_arr = []
    self.each { |i| new_arr << i unless new_arr.include?(i) }
    new_arr
  end

  def two_sum
    len = length
    result = []
    (0...len - 1).each do |i|
      (i + 1...len).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end

    result
  end
end

a, b, c = [4, 3, 2, 1], [], []
tower = { 1 => a, 2 => b, 3 => c }
loop do
  p a
  p b
  p c
  p 'Which column to move from?'
  initial_tower = tower[gets.chomp.to_i]
  if initial_tower.empty?
    p 'Tower is empty'
    next
  end
  p 'What tower do you want to move it to?'
  destination_tower = tower[gets.chomp.to_i]
  unless initial_tower.empty?
    if destination_tower.empty? || initial_tower.last < destination_tower.last
      destination_tower << initial_tower.pop
      p 'You win' && break if destination_tower == [4, 3, 2, 1]
    else
      p 'not possible'
    end
  end
end


def my_transpose(matrix)
  result = []
  len = matrix[0].length
  (0...len).each do |i|
    col = []
    matrix.each { |row| col << row[i] }
    result << col
  end
  result
end


def stock_picker(arr)
  len = arr.length
  profit = [0, 0]
  (0...len - 1).each do |i|
    (i + 1...len).each do |j|
      profit = [i, j] if arr[j] - arr[i] > arr[profit[1]] - arr[profit[0]]
      p profit
    end
  end
  profit
end

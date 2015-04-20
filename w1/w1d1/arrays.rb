class Array

  def my_uniq
    new_arr = []
    self.each { |i| new_arr << i unless new_arr.include?(i) }

    new_arr
  end

  def two_sum
    result = []
    (0...length - 1).each do |i|
      (i + 1...length).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end

    result
  end
end


def my_transpose(matrix)
  result = []
  (0...matrix[0].length).each do |i|
    col = []
    matrix.each { |row| col << row[i] }
    result << col
  end

  result
end


def stock_picker(arr)
  profit = [0, 0]
  (0...arr.length - 1).each do |i|
    (i + 1...arr.length).each do |j|
      profit = [i, j] if arr[j] - arr[i] > arr[profit[1]] - arr[profit[0]]
    end
  end

  profit
end

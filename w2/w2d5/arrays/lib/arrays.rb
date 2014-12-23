class Array


  def my_uniq
    output = []
    each do |i|
      output << i unless output.include?(i)
    end
    output
  end

  def two_sum
    pairs = []
    0.upto(length - 2) do |i|
      (i + 1).upto(length - 1) do |j|
        pairs << [i, j] if self[i] + self[j] == 0
      end
    end
    pairs
  end
end

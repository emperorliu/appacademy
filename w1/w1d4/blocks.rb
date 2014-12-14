class Array

  def my_each(&prc)
    i = 0
    while i < length
      prc.call self[i]
      i += 1
    end
    self
  end

  def my_map(&prc)
    i = 0
    new_arr = []
    my_each { |i| new_arr << prc.call(i) }
    new_arr
  end

  def my_select(&prc)
    i = 0
    new_arr = []
    my_each { |i| new_arr << i if prc.call(self[i]) }
    new_arr
  end

  def my_inject(default=nil, &prc)
    result = default
    my_each do |i|
      if result.nil?
        result = i
      else
        result = prc.call(result, i)
      end
    end
    result
  end

  def my_sort!(&prc)
    (length - 1).times do
      0.upto(length - 1).my_each do |i|
        if prc.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
        else
          prc.call(self[i], self[i + 1])
        end
      end
    end
    self
  end


  def my_sort(&prc)
    new_arr = self.dup
    new_arr.my_sort!(&prc)
end


def eval_block(*args, &prc)
  if block_given?
    prc.call(*args)
  else
    raise "NO BLOCK GIVEN"
  end
end

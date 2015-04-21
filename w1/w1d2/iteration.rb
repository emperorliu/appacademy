def factors(num)
  (1..num / 2).select { |i| num % i == 0 }
end

def bubble_sort(arr)
  arr.length.times do
    i = 0
    while arr.length - 1 - i > 0
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
      end
      i += 1
    end
  end

  arr
end

def substrings(str)
  letters = str.split('')
  strings = []
  (1..letters.length).each { |i| strings += letters.each_cons(i).to_a }

  strings.map(&:join)
end

def subwords(str, words)
  words = File.readlines("dictionary.txt").map(&:chomp)
  substrings(str).select { |i| words.include?(i) }
end

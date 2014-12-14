class WordChainer

  attr_reader :dictionary, :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
  end

  def adjacent_word(word)
    children = []
    0.upto(word.length).each do |i|
      temp = word.dup
      temp[i] = "."
      children += dictionary.select do |w|
        w.match(temp) and w.length == word.length
      end
    end
    children
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]
    until current_words.empty?
      new_current_words = []
      all_seen_words.each do |word|
        if !all_seen_words.include?(source) and word.adjacent_word(source)
          new_current_words << word
        end
      end
    end
  end

end





class Node
  attr_reader :value
  attr_accessor :parent

  def initialize(value, parent=nil)
    @value = value
    @parent = parent
  end
end

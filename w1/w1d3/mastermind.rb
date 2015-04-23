class Code
  CODES = %w(R G Y B O P)

  attr_reader :secret_code

  def initialize
    @secret_code = self.class.random
  end

  def self.random
    (1..4).map { CODES.sample }
  end

  def self.parse(string)
    string.upcase.split('')
  end

  def exact_matches(other_code)
    matches = 0
    secret_code.each_index do |i|
      matches += 1 if secret_code[i] == other_code[i]
    end
    matches
  end

  def near_matches(other_code)
    matches = 0
    other_code.each do |color|
      matches += 1 if secret_code.include?(color)
    end
    matches - exact_matches(other_code)
  end

end

class Game
  attr_accessor :turns, :secret_code, :guess

  def initialize
    @turns = 0
    @secret_code = Code.new
    @guess = []
  end

  def play
    until over?
      guess = get_guess
      turns += 1
      exact = secret_code.exact_matches(guess)
      near = secret_code.near_matches(guess)
      puts "Exact: #{exact}"
      puts "Near: #{near}"
      puts "You have #{10 - turns} left."
    end
  end

  def over?
    if secret_code.exact_matches(guess) == 4
      puts "you win!"
      true
    elsif turn == 10
      puts "you lose!"
      true
    else
      false
    end
  end

  def get_guess
    print "Make a guess: "
    guess = Code.parse(gets.chomp)
    if guess.length != guess.uniq.length
      raise "Please only use one of each color"
    else
      guess
    end
  rescue => e
    puts e.message
    retry
  end
end

game = Game.new
game.play

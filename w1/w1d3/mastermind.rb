class Code
  CODES = %w(R G Y B O P)

  attr_reader :pegs

  def initialize(@pegs)
    @pegs = pegs
  end

  def self.random
    pegs = (1..4).map { CODES.sample }
    Code.new(pegs)
  end

  def self.parse(string)
    pegs = string.upcase.split('')
    Code.new(pegs)
  end

  def exact_matches(other_code)
    matches = 0
    pegs.each_index do |i|
      matches += 1 if pegs[i] == other_code[i]
    end

    matches
  end

  def near_matches(other_code)
    matches = 0
    other_code.each do |color|
      matches += 1 if pegs.include?(color)
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
      self.turns += 1
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
    elsif turns == 10
      puts "you lose!"
      true
    else
      false
    end
  end

  def get_guess
    print "Make a guess: "
    Code.parse(gets.chomp)
  end
end

game = Game.new
game.play

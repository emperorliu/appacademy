class Code
  CODES = %w(R G Y B O P)

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def self.random
    codes = (1..4).map { CODES.sample }
    Code.new(codes)
  end

  def self.parse(string)
    codes = string.upcase.split('')
    Code.new(codes)
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
    @secret_code = Code.random
    @guess = nil
  end

  def play
    puts secret_code.pegs.join('')
    until over?
      self.guess = get_guess
      self.turns += 1
      exact = secret_code.exact_matches(guess.pegs)
      near = secret_code.near_matches(guess.pegs)
      puts "Exact: #{exact}"
      puts "Near: #{near}"
      puts "You have #{10 - turns} left."
    end

    puts "The secret code was #{secret_code.pegs.join('')}!"
  end

  def over?
    if guess && secret_code.exact_matches(guess.pegs) == 4
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

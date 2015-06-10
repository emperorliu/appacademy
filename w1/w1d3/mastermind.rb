require 'colorize'
require 'byebug'

class Code
  CODES = %i(r g y b o p)
  COLORS = { r: :red, g: :green, y: :yellow, b: :blue, o: :orange, p: :purple }

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def self.random
    codes = (1..4).map { CODES.sample }
    Code.new(codes)
  end

  def self.parse(string)
    codes = string.downcase.chars.map(&:to_sym)
    Code.new(codes)
  end

  def exact_matches(other_code)
    matches = 0
    other_pegs = other_code.pegs
    pegs.each_index do |i|
      matches += 1 if pegs[i] == other_pegs[i]
    end

    matches
  end

  def near_matches(other_code)
    matches = 0
    other_code.pegs.each do |color|
      matches += 1 if pegs.include?(color)
    end

    matches - exact_matches(other_code)
  end

  def display
    pegs.map { |peg| COLORS[peg] }
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
      exact = secret_code.exact_matches(guess)
      near = secret_code.near_matches(guess)
      puts "Exact: #{exact}"
      puts "Near: #{near}"
      puts "You have #{10 - turns} left."
    end

    puts "\nThe secret code was #{secret_code.pegs.join('')}!"
  end

  def over?
    if guess && secret_code.exact_matches(guess) == 4
      puts "\nYou win!"
      true
    elsif turns == 10
      puts "\nYou lose!"
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

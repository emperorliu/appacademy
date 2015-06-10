require 'colorize'
require 'byebug'

class Code
  CODES = %i(r g y b o p)
  # actual words
  # COLORS = { r: :red, g: :green, y: :yellow, b: :blue, o: :orange, p: :purple }

  # squares with different shading
  # COLORS = {
  #   r: "\u25A4", g: "\u25A5", y: "\u25A6", b: "\u25A7", o: "\u25A8", p: "\u25A9"
  # }

  # different shapes
  COLORS = {
    r: "\u2688", g: "\u2726", y: "\u2736", b: "\u2737", o: "\u272D", p: "\u2739"
  }
  CLI_COLORS = {
    r: :red, g: :green, y: :light_yellow, b: :cyan, o: :yellow, p: :blue
  }

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
    pegs.map { |i| i.to_s.colorize(CLI_COLORS[i]) }.join(" ")
    # pegs.map { |i| COLORS[i].to_s.colorize(CLI_COLORS[i]) }.join(" ")
    # pegs.map { |i| "\u25A8".colorize(CLI_COLORS[i]) }.join(" ")
  end
end

class Game
  attr_accessor :turns, :secret_code, :guess

  def initialize
    @turns = 10
    @secret_code = Code.random
    @guess = nil
  end

  def play
    puts secret_code.display
    until over?
      @guess = get_guess
      @turns -= 1
      exact = secret_code.exact_matches(guess)
      near = secret_code.near_matches(guess)
      puts "Your guess #{guess.display}"
      puts "Exact: #{exact}"
      puts "Near: #{near}"
      puts "You have #{turns} left."
    end

    puts "\nThe secret code was #{secret_code.display}"
  end

  def over?
    if guess && secret_code.exact_matches(guess) == 4
      puts "\nYou win!"
      true
    elsif turns == 0
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

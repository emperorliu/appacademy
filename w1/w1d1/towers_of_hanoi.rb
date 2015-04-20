require 'colorize'

class TowersOfHanoi

  attr_reader :towers, :complete_tower

  def initialize
    @complete_tower = (1..5).to_a.reverse
    @towers = [complete_tower.dup, [], []]
  end

  def play
    display
    until won?
      begin
        p 'Move from, to:'
        from, to = get_move(gets.chomp)
      rescue ArgumentError => e
        puts e.message
        retry
      end
      next if illegal_move?(from, to)

      display
    end
  end

  def won?
    if towers.last == complete_tower
      puts 'You win!'
      true
    else
      false
    end
  end

  def get_move(input)
    input = input.split(",").map(&:strip).map(&:to_i)
    arr = [1, 2, 3]
    unless arr.include?(input[0]) && arr.include?(input[1])
      raise ArgumentError.new "invalid input"
    end

    input.map { |i| i - 1 }
  end

  def illegal_move?(from, to)
    if towers[from].empty?
      p 'Tower is empty'
      true
    elsif towers[to].empty? || towers[from].last < towers[to].last
      towers[to] << towers[from].pop
      false
    else
      p 'Illegal move'
      true
    end
  end

  def render
    (complete_tower.length - 1).downto(0).map do |height|
      towers.map do |stack|
        if stack[height].nil?
          "\u2551"
        else
          stack[height].to_s.colorize(:red)
        end
      end.join("\t")
    end.join("\n")
  end

  def display
    puts "\e[H\e[2J"
    puts render
    puts "\u2569" + "\u2550" * 7 + "\u2569" + "\u2550" * 7 + "\u2569"
  end

end


game = TowersOfHanoi.new
game.play

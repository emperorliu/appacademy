class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move
    puts "Make a move."
    gets.chomp.split(', ').map(&:to_i)
  end
end

class ComputerPlayer
  attr_reader :name
  attr_accessor :size

  def initialize(size = 3)
    @size = size
    @name = "#{rand(100...1000)}-c0Mpv73r"
  end

  def move
    [rand(0...size), rand(0...size)]
  end
end

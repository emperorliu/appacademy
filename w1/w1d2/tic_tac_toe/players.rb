class HumanPlayer
  attr_reader :name, :mark

  def initialize(options)
    @name = options[:name]
    @mark = options[:mark]
  end

  def move
    puts "Make a move."
    gets.chomp.split(', ').map(&:to_i)
  end
end

class ComputerPlayer
  attr_reader :name, :mark
  attr_accessor :size

  def initialize(options)
    @size = options[:size]
    @name = "#{rand(100...1000)}-c0Mpv73r"
    @mark = options[:mark]
  end

  def move
    [rand(0...size), rand(0...size)]
  end
end

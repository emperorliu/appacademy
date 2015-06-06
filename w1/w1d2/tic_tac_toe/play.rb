require_relative 'game'

human = HumanPlayer.new("Human")
computer = ComputerPlayer.new
game = Game.new(size: 3, x: human, o: computer)
game.play

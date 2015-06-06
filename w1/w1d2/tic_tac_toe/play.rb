require_relative 'game'

game = Game.new(size: 3, x: :human, o: :ai)
game.play

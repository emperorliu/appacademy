#! /usr/bin/env ruby
require_relative 'game'

player_x = ARGV.shift.to_sym
player_o = ARGV.shift.to_sym
size = ( ARGV.length == 1 ? ARGV.shift.to_i : 3 )


if __FILE__ == $PROGRAM_NAME
  game = Game.new(size: size, x: player_x, o: player_o)
  game.play
end

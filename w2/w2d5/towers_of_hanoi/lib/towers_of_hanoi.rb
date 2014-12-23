

class TowersOfHanoi
  attr_accessor :towers
  def initialize
    @towers = { 1 => [3, 2, 1], 2 => [], 3 => [] }
  end

  def move(from, to)
    disk_in_play = towers[from].pop
    if towers[to].any?
      if towers[to].last < disk_in_play
        raise "Illegal move"
      end
    else
      towers[to] << disk_in_play
    end
  end


end
#
# tower = { 1 => [3, 2, 1], 2 => [], 3 => [] }
# loop do
#   tower.values.each { |stack| p stack }
#   p 'Move from:'
#   initial_tower = tower[gets.chomp.to_i]
#   if initial_tower.empty?
#     p 'Tower is empty'
#     next
#   end
#   p 'Move to:'
#   destination_tower = tower[gets.chomp.to_i]
#   unless initial_tower.empty?
#     if destination_tower.empty? || initial_tower.last < destination_tower.last
#       destination_tower << initial_tower.pop
#       p 'You win' && break if destination_tower == [4, 3, 2, 1]
#     else
#       p 'Illegal move'
#     end
#   end
# end

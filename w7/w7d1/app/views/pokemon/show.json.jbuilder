# json.pokemon do
  json.partial! 'pokemon/pokemon', pokemon: @pokemon
# end

unless @pokemon.toys.empty?
  json.toys @pokemon.toys do |toy|
    json.partial! 'toys/toy', toy: toy
  end
end

Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  $li = $('<li>');
  $li.addClass('poke-list-item');
  $li.text(pokemon.get('name') + ': ' + pokemon.get('poke_type'));
  $li.attr("data-pokemon-id", pokemon.id);
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({success: function() {
    that.pokes.each( function(pokemon) {
      that.addPokemonToList(pokemon);
    })}
  });
};

Pokedex.RootView.prototype.createPokemon = function (attrs) {
  var newPokemon = new Pokedex.Models.Pokemon(attrs);
  var view = this;
  newPokemon.save({}, {
    success: function () {
      view.pokes.add(newPokemon);
      view.addPokemonToList(newPokemon);
      view.renderPokemonDetail(newPokemon);
    }
  });

};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var attrs = this.$newPoke.serializeJSON('pokemon');
  this.createPokemon(attrs);
};

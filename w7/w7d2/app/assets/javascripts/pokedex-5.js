Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li.poke-list-item' : 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({ pokemon: pokemon });
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: (function () {
        this.render();
        options.success && options.success();
      }).bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.each( function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this))
  },

  selectPokemonFromList: function (event) {

    var pokemonId = $(event.currentTarget).data("id");
    var pokemon = this.collection.get(pokemonId);

    Backbone.history.navigate(
      "/pokemon/" + pokemonId,
      { trigger: true }
    );
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click li.toy-list-item' : 'selectToyFromList'
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: function () {
        this.render();
        options.success && options.success();
      }.bind(this)
    })
  },

  render: function () {

    this.$el.html(JST["pokemonDetail"]({pokemon: this.model}));

    this.model.toys().each( function (toy) {
      this.$el.append(JST["toyListItem"]({ toy: toy }));
    }.bind(this))
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("id");
    var toy = this.model.toys().get(toyId);

    Backbone.history.navigate(
      "/pokemon/" + toy.get("pokemon_id") + "/toys/" + toyId,
      { trigger: true }
    );
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.html(JST["toyDetail"]({toy: this.model, pokes: _([])}));
    return this;
  }
});

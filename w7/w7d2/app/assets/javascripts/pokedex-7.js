Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form.new-pokemon": "savePokemon"
  },

  render: function () {
    this.$el.html(JST["pokemonForm"]({ pokemon: this.model.id }));
  },

  savePokemon: function (event) {
    event.preventDefault();
    var $form = $(event.currentTarget);
    var data = $form.serializeJSON().pokemon;
    this.model.save(data, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate(
          "/pokemon/" + this.model.id,
          { trigger: true }
        );
      }.bind(this)
    })
  }
});

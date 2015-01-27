Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $div = $('<div>');
  $div.addClass('detail');
  var $img = $('<img>');
  $img.attr('src', pokemon.get('image_url'));
  $div.append($img);
  var keys = _.keys(pokemon.attributes)
  _.each(keys, function(key) {
    if (key === "image_url") { return }
    $detailDiv = $('<div>');
    $detailDiv.text(key + ": " + pokemon.get(key));
    $div.append($detailDiv);
  });
    $div.attr("data-pokemon-id", pokemon.id);


  // displaying toys
  $ul = $('<ul>');
  $ul.addClass('toys');
  $div.append($ul);

  var that = this;
  pokemon.fetch({
    success: function() {
      pokemon.toys().each(function (toy) {
        that.addToyToList(toy);
      });
    }
  });

  this.$pokeDetail.append($div);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  this.$pokeDetail.empty();
  var $li = $(event.currentTarget);
  var id = $li.attr("data-pokemon-id");
  var pokemon = this.pokes.get(id);
  this.renderPokemonDetail(pokemon);
};

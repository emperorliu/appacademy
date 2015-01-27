Pokedex.RootView.prototype.addToyToList = function (toy) {
  $li = $('<li>');
  $li.addClass('toy-list-item');
  var name = toy.get('name');
  var happiness = toy.get('happiness');
  var price = toy.get('price');
  $li.attr('data-toy-id', toy.id);

  $li.text("name: " + name + ", " + happiness + ", " + price)
  this.$pokeDetail.find('ul.toys').append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $div = $('<div>');
  $div.addClass('toy-detail');
  var $img = $('<img>');
  $img.attr('src', toy.get('image_url'));
  $div.append($img);
  this.$toyDetail.append($div);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  this.$toyDetail.empty();
  var $li = $(event.currentTarget);
  var pokemonId = this.$pokeDetail.children().attr("data-pokemon-id");
  var pokemon = this.pokes.get(pokemonId);
  var toyId = $li.attr("data-toy-id");
  var toy = pokemon.toys().get(toyId);
  this.renderToyDetail(toy);
};

Pokedex.Models.Pokemon.prototype.toys = function () {
  if (typeof this._toys === "undefined") {
    this._toys = new Pokedex.Collections.PokemonToys();
  }
  return this._toys;
};

Pokedex.Models.Pokemon.prototype.parse = function (payload) {
  var toys = [];
  if (payload.toys) {
    _.each(payload.toys, function (attrs) {
      var newToy = new Pokedex.Models.Toy(attrs);
      toys.push(newToy);
    });
    delete payload.toys;
  };
  this.toys().set(toys);

  return payload;
};

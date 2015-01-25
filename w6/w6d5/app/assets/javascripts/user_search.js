$.UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input[name=search]");
  this.$ul = this.$el.find(".users");

  // this.render(this.$ul);
  this.$el.on("input", this.handleInputs.bind(this));
};

$.UserSearch.prototype.render = function(users) {
  this.$ul.empty();

  for (var i = 0; i < users.length; i++) {
    var user = users[i];

    var $a = $("<a>")
    $a.text(user.username);
    $a.attr("href", "/users/" + user.id);

    var $toggleButton = $("<button>");
    $toggleButton.followToggle({
      userId: user.id,
      followState: user.followed ? "followed" : "unfollowed"
    });

    var $li = $("<li>");
    $li.append($a);
    $li.append($toggleButton);
    this.$ul.append($li);
  }
};

$.UserSearch.prototype.handleInputs = function () {
  if (this.$input.val() === "") {
    this.render([]);
    return;
  }
  $.ajax ({
    url: "/users/search",
    method: "GET",
    data: { query: this.$input.val() },
    dataType: "json",
    success: this.render.bind(this)
  });
};

$.fn.userSearch = function () {
  return this.each(function () {
    new $.UserSearch(this);
  });
};

$(function () {
  $(".user-search").userSearch();
});

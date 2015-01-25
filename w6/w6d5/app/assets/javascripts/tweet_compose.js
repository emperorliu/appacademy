$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("textarea[name='tweet[content]']");
  this.$input.on("input", this.handleInputs.bind(this));
  this.$el.on("submit", this.submit.bind(this));

}

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();

  var data = this.$el.serializeJSON();
  this.$el.find(":input").prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: data,
    dataType: "json",
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.clearInput = function () {
  this.$input.val("");
  this.$el.find(":input").prop("disabled", false);
};


$.TweetCompose.prototype.handleSuccess = function () {
  var $tweets = this.$el.find(".tweets-ul");
  this.clearInput();

};

$.TweetCompose.prototype.handleInputs = function () {
  var $strong = this.$el.find('.chars-left');
  $strong.text(140 - this.$input.val().length);
  $strong.css("color", "black");
  this.$input.css("color", "black");

  if (this.$input.val().length <= 140) {
    this.$el.find("input[value='Post Tweet!']").prop("disabled", false);
  } else {
    $strong.css("color", "red");
    this.$input.css("color", "#aaa");
    this.$el.find("input[value='Post Tweet!']").prop("disabled", true);
  }
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $(".tweet-compose").tweetCompose();
});

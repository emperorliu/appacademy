$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.$el.on("click", this.clickHandler.bind(this));
};

$.FollowToggle.prototype.render = function() {
  if (this.followState === "followed") {
    this.$el.text("Unfollow!");
  } else if (this.followState === "unfollowed") {
    this.$el.text("Follow!");
  }
};

$.FollowToggle.prototype.clickHandler = function (event) {
  event.preventDefault();

  this.$el.prop("disabled", true);

  var that = this;
  var type = "DELETE";
  var followed = "followed"
  if (this.followState === "followed") {
    followed = "unfollowed"
  } else if (this.followState === "unfollowed") {
    type = "POST"
  }

  $.ajax ({
    url: "/users/" + this.userId + "/follow",
    method: type,
    dataType: "json",
    success: function () {
      that.$el.prop("disabled", false);
      that.followState = followed;
      that.render();
    }
  });
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});

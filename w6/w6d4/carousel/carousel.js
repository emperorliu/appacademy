$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.totalImgs = this.$el.find('.items').children().length;
  this.$el.find("a").on("click", this.clickLink.bind(this));
  this.trans = false;
};

$.Carousel.prototype.clickLink = function (event) {
  if (!this.trans) {
    this.trans = true;
    var $activeLink = $(event.currentTarget);
    var $items = this.$el.find('img');
    if ($activeLink.attr('class') === "slide-right") {
      this.slideRight($items);
    } else if ($activeLink.attr('class') === "slide-left") {
      this.slideLeft($items);
    }
  }
}

$.Carousel.prototype.slideRight = function (items) {
  var $prevImg = items.eq(this.activeIdx);
  this.activeIdx = (this.totalImgs + (this.activeIdx - 1)) % this.totalImgs;
  var $nextImg = items.eq(this.activeIdx);

  $nextImg.addClass("active left");

  $prevImg.one("transitionend", function(){
    $prevImg.removeClass("active right");
    this.trans = false;
  }.bind(this));

  setTimeout((function(){
    $prevImg.addClass("right");
    $nextImg.removeClass("left");
  }), 0);
};

$.Carousel.prototype.slideLeft = function (items) {
  var $prevImg = items.eq(this.activeIdx);
  this.activeIdx = (this.activeIdx + 1) % this.totalImgs;
  var $nextImg = items.eq(this.activeIdx);

  $nextImg.addClass("active right");

  $prevImg.one("transitionend", function(){
    $prevImg.removeClass("active left");
    this.trans = false;
  }.bind(this));

  setTimeout((function(){
    $prevImg.addClass("left");
    $nextImg.removeClass("right");
  }), 0);
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};

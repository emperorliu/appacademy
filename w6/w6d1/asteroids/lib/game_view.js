(function(){
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function (ctx) {
    this.game = new Asteroids.Game();
    this.ctx = ctx;
    this.bindKeyHandlers();
  };

  GameView.prototype.start = function (canvasEl) {
    var ctx = canvasEl.getContext("2d");

    window.setInterval((function () {
      this.game.step();
      this.game.draw(ctx);
    }).bind(this), 1000 / 60);
  };

  GameView.prototype.bindKeyHandlers = function () {
    // define short of 'a'
    var that = this;
    var accel = 0.2;
    key('a', function(){ that.game.ship.power([-accel, 0]) });
    key('w', function(){ that.game.ship.power([0, -accel]) });
    key('d', function(){ that.game.ship.power([accel, 0]) });
    key('s', function(){ that.game.ship.power([0, accel]) });
    key('space', function(){
      // debugger
      that.game.ship.fireBullet(that.game)
      });
  };
})();

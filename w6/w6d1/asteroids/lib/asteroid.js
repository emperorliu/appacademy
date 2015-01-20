(function(){
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Asteroid = Asteroids.Asteroid = function (options){
    options.color = Asteroid.COLOR;
    options.radius = Asteroid.RADIUS;
    // options.pos = options.pos || Asteroids.Game.pos;
    options.vel = options.vel || Util.randomVect(Asteroid.SPEED);
    Asteroids.MovingObject.call(this, options);
  };

  Asteroid.COLOR = 'green';
  Asteroid.RADIUS = 20;
  Asteroid.SPEED = 2;

  Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collidedWith = function (game, otherObject) {
    if (this.isCollidedWith(game.ship)) {
      game.ship.relocate();
    } else {
      game.remove(otherObject);
      game.remove(this);
    }
  };


})();

(function(){
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function (options){
    options.color = Bullet.COLOR;
    options.radius = Bullet.RADIUS;
    // options.pos = options.pos || Asteroids.Game.randomPosition();
    options.vel = options.vel || Util.randomVect(Bullet.SPEED);
    Asteroids.MovingObject.call(this, options);
  };

  Bullet.COLOR = 'red';
  Bullet.RADIUS = 3;
  Bullet.SPEED = 12;

  Util.inherits(Asteroids.Bullet, Asteroids.MovingObject);

  Bullet.prototype.collidedWith = function (game, otherObject) {
    if (this.isCollidedWith(otherObject)) {
      game.remove(otherObject);
      game.remove(this);
    }
  };

  Bullet.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  }

})();

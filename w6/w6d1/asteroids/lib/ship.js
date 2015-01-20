(function(){
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (options){
    options.color = Ship.COLOR;
    options.radius = Ship.RADIUS;
    // options.pos = options.pos || Asteroids.Game.randomPosition();
    options.vel = [0, 0];
    Asteroids.MovingObject.call(this, options);
  };

  Ship.COLOR = '#05f';
  Ship.RADIUS = 10;
  // Ship.SPEED = 2;

  Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function () {
    this.vel = [0, 0];
    this.pos = Asteroids.Game.randomPosition();
  };

  Ship.prototype.power = function(impulse) {
    this.vel[0] += 5 * impulse[0];
    this.vel[1] += 5 * impulse[1];
  }

  Ship.prototype.fireBullet = function (game) {
    var posx = this.pos[0];
    var posy = this.pos[1];
    var velx = this.vel[0];
    var vely = this.vel[1];
    var bullet = new Asteroids.Bullet({pos: [posx, posy], vel: [velx, vely]});
    game.add(bullet);
  };

})();

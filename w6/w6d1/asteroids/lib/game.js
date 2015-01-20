(function(){
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.bullets = [];
    this.ship = new Asteroids.Ship ({pos: Game.randomPosition()})
    this.addAsteroids();
  };

  Game.DIM_X = 800;
  Game.DIM_Y = 500;
  Game.NUM_ASTEROIDS = 20;

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push( new Asteroids.Asteroid({pos: Game.randomPosition()}) );
    }
  };

  Game.prototype.add = function (object) {
    if (object instanceof Asteroids.Asteroid) {
      this.asteroids.push(object);
    } else {
      this.bullets.push(object);
    }
  };

  Game.randomPosition = function () {
    var x = Math.floor(Math.random() * (Game.DIM_X - 1)) + 1;
    var y = Math.floor(Math.random() * (Game.DIM_Y - 1)) + 1;
;    return [x, y];
  };

  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.allObjects().forEach(function(asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.allObjects = function () {
    return this.asteroids.concat([this.ship].concat(this.bullets));
  };

  Game.prototype.moveObjects = function() {
    this.asteroids.forEach(function(asteroid) {
      asteroid.move();
    });

    this.ship.move();
  };

  Game.prototype.checkCollisions = function () {
    var objects = this.allObjects();
    for (var i = 0; i < objects.length - 1; i++) {
      for (var j = i + 1; j < objects.length; j++) {
        if (objects[i].isCollidedWith(objects[j])) {

          objects[i].collidedWith(this, objects[j]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (object) {
    if (object instanceof Asteroids.Asteroid) {
      var index = this.asteroids.indexOf(object);
      this.asteroids.splice(index, 1);
    } else {
      var index = this.bullets.indexOf(object);
      this.bullets.splice(index, 1);
    }
  };










})();

(function(){

  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function(argObj) {
    for (var key in argObj) {
      this[key] = argObj[key];
    }
  };

  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
    ctx.fill();
  };

  MovingObject.prototype.move = function () {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    if (this.pos[0] > Asteroids.Game.DIM_X ) {
      this.pos[0] = 0;
    } else if (this.pos[0] < 0 ) {
      this.pos[0] = Asteroids.Game.DIM_X;
    }
    if (this.pos[1] > Asteroids.Game.DIM_Y ) {
      this.pos[1] = 0;
    } else if (this.pos[1] < 1 ) {
      this.pos[1] = Asteroids.Game.DIM_Y;
    }
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var x1 = this.pos[0];
    var y1 = this.pos[1];
    var x2 = otherObject.pos[0];
    var y2 = otherObject.pos[1];
    var dist = Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2));

    return (dist < this.radius + otherObject.radius);
  };

  MovingObject.prototype.collidedWith = function (game, otherObject) {
    // if (this.isCollidedWith(otherObject)) {
    // game.remove(otherObject);
    // game.remove(this);
    // }
  };

})();

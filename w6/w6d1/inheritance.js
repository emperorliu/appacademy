Function.prototype.inherits = function (parentClass) {
  var Surrogate = function () {};
  Surrogate.prototype = parentClass.prototype;
  this.prototype = new Surrogate();
};

function MovingObject () {};

function Ship () {};
Ship.inherits(MovingObject);

function Asteroid () {};
Asteroid.inherits(MovingObject);

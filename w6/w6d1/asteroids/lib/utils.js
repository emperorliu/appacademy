if (typeof Asteroids === "undefined") {
  window.Asteroids = {};
}

var Util = Asteroids.Util = function () {};

Util.inherits = function (childClass, parentClass) {
  var Surrogate = function () {};
  Surrogate.prototype = parentClass.prototype;
  childClass.prototype = new Surrogate();
};

Util.randomVect = function (length) {
  // body...
  var x = Math.floor(Math.random() * (2 * length) - length);
  var y = Math.floor(Math.random() * (2 * length) - length);
  return [x, y];
};

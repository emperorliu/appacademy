function sum() {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }

  return total;
};


Function.prototype.myBind = function (obj) {
  var total = 0;

  var fn = this;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }

  return function() {
    return fn.apply(obj);
  }
};

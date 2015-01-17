Array.prototype.myEach = function(func) {
  for (var i = 0; i < this.length; i++ ) {
    func(this[i]);
  }
};

Array.prototype.myMap = function(callback) {
  var result = [];

  this.myEach(function(el) {
    result.push(callback(el));
  });

  return result;
};

Array.prototype.myInject = function() {
  var total = this[0];
  var rest = this.slice(1, this.length);

  rest.myEach(function(el) {
    total += el;
  });

  return total;
};

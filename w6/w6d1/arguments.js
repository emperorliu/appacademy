function sum() {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }

  return total;
};


Function.prototype.myBind = function (context) {
  var oldArgs = [].slice.call(arguments, 1);
  var that = this;

  return function () {
    var newArgs = [].slice.call(arguments, 0);
    return that.apply(context, oldArgs.concat(newArgs));
  }
};


function curriedSum(numArgs) {

  var numbers = [];
  var _curriedSum = function(num) {
    numbers.push(num);

    if (numbers.length === numArgs){
      return sum.apply({}, numbers)
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
};

console.log(curriedSum(2)(2)(3));

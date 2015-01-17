Array.prototype.bubbleSort = function() {
  var sorted = false;

  while (!sorted) {
    sorted = true;
    for ( var i = 0; i < this.length - 1; i++ ) {
      for ( var j = i + 1; j < this.length; j++ ) {
        if (this[i] > this[j]) {
          var temp = this[i];
          this[i] = this[j];
          this[j] = temp;
          sorted = false;
        }
      }
    }
  }
  return this;
};

function substrings(str) {
  var result =[];

  for ( var i = 0; i < str.length - 1; i++ ) {
    for ( var j = i; j < str.length; j++ ) {
      if (result.indexOf(str.slice(i, j+1)) === -1 ) {
        result.push(str.slice(i, j+1));
      }
    }
  }
  return result;
};

function myExp(b, n) {
  if (n === 0) {
    return 1;
  } else {
    return b * myExp(b, n - 1);
  }
};


function fibonacci(n) {
  if (n <= 2) {
    return [0, 1].slice(0, n);
  } else {
    var fib = fibonacci(n - 1);
    fib.push(fib[fib.length - 2] + fib[fib.length - 1]);
    return fib;
  }
};

function binarySearch(arr, target) {
  if (arr.length === 0) {
    return null;
  } else if (arr.length === 1 && arr[0] != target ) {
    return null;
  } else {
    var pivot = Math.floor(arr.length / 2);
    if (target === arr[pivot]) {
      return pivot;
    } else if (target < arr[pivot]) {
      return binarySearch(arr.slice(0, pivot), target);
    } else {
      var recb = binarySearch(arr.slice(pivot + 1, arr.length), target);
      if (recb === null ) {
        return null;
      } else {
      return pivot + 1 + recb;
      }
    }
  }
};

Array.prototype.uniq = function() {
  var result = [];

  for (var i = 0; i < this.length; i++ ) {
    if (result.indexOf(this[i]) === -1 ) {
      result.push(this[i]);
    }
  }

  return result;
};

Array.prototype.twoSum = function() {
  var result = [];

  for (var i = 0; i < this.length; i++ ) {
    for (var j = (i + 1); j < this.length; j++ ) {
      if ( this[i] + this[j] === 0 ) {
        result.push([i, j]);
      }
    }
  }

  return result;
};


Array.prototype.transpose = function() {
  var result = [];

  for (var i = 0; i < this.length; i++ ) {
    var row = [];
    for (var j = 0; j < this.length; j++ ) {
      row.push(this[j][i]);
    }
    result.push(row);
  }

  return result;
};

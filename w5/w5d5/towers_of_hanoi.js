var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);


function TowersOfHanoi() {
  this.stacks = [[3, 2, 1], [], []];
};

function last(array) { return array[array.length - 1] };

TowersOfHanoi.prototype.isWon = function() {
  return this.stacks[2].length === 3;
};

TowersOfHanoi.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  var startStack = this.stacks[startTowerIdx];
  var endStack   = this.stacks[endTowerIdx];
  if (startStack.length === 0) {
    return false;
  } else if (endStack.length === 0) {
    return true;
  } else if (last(startStack) < last(endStack)) {
    return true;
  } else {
    return false;
  }
};


TowersOfHanoi.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(last(this.stacks[startTowerIdx]))
    this.stacks[startTowerIdx].splice(this.stacks[startTowerIdx].length - 1)
  } else {
    console.log("Illigal move!");
  }
};

TowersOfHanoi.prototype.promptMove = function (callback) {
  reader.question("Move from: ", function(from) {
    reader.question("Move to: ", function(to) {
      return callback(from - 1, to - 1);
    });
  });
};

TowersOfHanoi.prototype.run = function (callback) {
  // display stacks
  console.log(JSON.stringify(this.stacks));

  this.promptMove(function(from, to) {
    this.move(from, to);
    this.isWon() ? callback() : this.run(callback);
  }.bind(this));
};

a = new TowersOfHanoi();
a.run(function(){
  console.log("You're done!")
  reader.close();
});

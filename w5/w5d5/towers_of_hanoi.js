var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);


function TowersOfHanoi() {
  this.stacks = [[3, 2, 1], [], []];
};

TowersOfHanoi.prototype.isWon = function() {
  if (this.stacks[2].length === 3 ) {
    reader.close;
    return true;
  } else {
    return false;
  }
};

function last(array) { return array[array.length - 1] };

TowersOfHanoi.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {

  if (this.stacks[startTowerIdx].length === 0) {
    return false;
  } else if (this.stacks[endTowerIdx].length === 0) {
    return true;
  } else if (last(this.stacks[startTowerIdx]) < last(this.stacks[endTowerIdx])) {
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
    console.log("Illigal move, noooooooob!");
  }
};

TowersOfHanoi.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
  return;
};

TowersOfHanoi.prototype.promptMove = function (callback) {
  reader.question("Move from: ", function(from) {
    reader.question("Move to: ", function(to) {
      return callback(from, to);
    });
  });
};

TowersOfHanoi.prototype.run = function (callback) {
  this.print();
  var that = this;
  this.promptMove(function(from, to) {

    that.move(from, to);

    if (that.isWon()) {

      callback();
    } else {
      that.run(callback);
    }
  })
};

a = new TowersOfHanoi();
a.run(function(){
  console.log("You're done!")
  reader.close();
});




// stacks[0][stacks.length - 1]

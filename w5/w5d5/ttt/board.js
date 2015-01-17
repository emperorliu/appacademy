// var index = require('index.js')
// var game = require('game.js')

function Board () {
  this.board = [Array(3), Array(3), Array(3)];
}

Board.prototype.print = function () {
  console.log(this.board[0]);
  console.log(this.board[1]);
  console.log(this.board[2]);
};

Board.prototype.isWon = function () {
  return this.winner();
};

Board.WinningCombinations = [
  [[0, 0], [0, 1], [0, 2]],
  [[1, 0], [1, 1], [1, 2]],
  [[2, 0], [2, 1], [2, 2]],
  [[0, 0], [1, 0], [2, 0]],
  [[0, 1], [1, 1], [2, 1]],
  [[0, 2], [1, 2], [2, 2]],
  [[0, 0], [1, 1], [2, 2]],
  [[2, 0], [1, 1], [0, 2]]
  ]

Board.prototype.winner = function () {
  // symbol of winner
};

Board.prototype.isEmpty = function(pos) {
  var x = pos[0];
  var y = pos[1];

  if (x < 3 && x >= 0 && y < 3 && y >= 0 ) {
    return (this.board[x][y] === undefined);
  } else {
      return callback()
    return;
  }

};

Board.prototype.placeMark = function(pos, mark) {
  var x = pos[0];
  var y = pos[1];
  if (this.isEmpty(pos)) {
    this.board[x][y] = mark;
    return true;
  } else {
    return false;
  }
};



a = new Board()
a.print();

module.exports = Board;

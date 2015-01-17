var Board = require('./board.js')
// var index = require('index.js')

var readline = require('readline')
var reader = readline.createInterface(process.stdin, process.stdout, null);



function Game (player1, player2) {
  this.board = new Board();
  this.player1 = player1
  this.player2 = player2
}

Game.prototype.play = function(cb) {
  this.curr_mark = "X";
  this.turn(this.curr_mark, cb)
}

function flipMark(mark) {
  if (mark == "X") {
    return "O";
  } else {
    return "X";
  }
};

Game.prototype.turn = function(mark, cb) {
  this.board.print();
  var that = this;
  this.promptPlayer(function(pos) {
    if (that.board.placeMark(pos, mark)) {
      if (that.board.isWon()){
        this.board.print();
        return cb();
      } else {
        that.turn(flipMark(mark), cb);
      }
    } else {
      that.turn(mark, cb);
    }
  });
};

Game.prototype.promptPlayer = function(callback) {
  reader.question("Input move!", function(pos) {
    var pos = pos.split(', ');
    return callback(pos);
  });

}

g = new Game()

g.play(function(){
  console.log('game over');
})

(function(){
  var S = window.S = window.S || {};

  var Snake = S.Snake = function(){
    var coord = Math.floor(S.Snake.BOARDSIZE / 2);
    this.segments = [[coord, coord]];
    this.dir = [0,0];
  }

  Snake.prototype.move = function () {
    this.segments.unshift(addCoords(this.dir, this.segments[0]));
    this.segments.splice(this.segments.length - 1);
  };

  Snake.DIR = {"N": [0,-1], "E": [1,0], "S":[0,1], "W": [-1,0]}
  S.Snake.BOARDSIZE = 8;

  Snake.prototype.turn = function(dir){
    this.dir = Snake.DIR[dir];
  };

  function addCoords (arr1, arr2) {
    var x1 = arr1[0];
    var y1 = arr1[1];
    var x2 = arr2[0];
    var y2 = arr2[1];
    var x3 = (x1 + x2);
    var y3 = (y1 + y2);
    if (x3 > S.Snake.BOARDSIZE - 1) {
      x3 = 0;
    } else if (x3 < 0) {
      x3 = S.Snake.BOARDSIZE - 1;
    }
    if (y3 > S.Snake.BOARDSIZE - 1) {
      y3 = 0;
    } else if (y3 < 0) {
      y3 = S.Snake.BOARDSIZE - 1;
    }
    return [x3, y3];
  }


  var Board = S.Board = function(){
    this.snake = new Snake();
    this.grid = new Array(Snake.BOARDSIZE);
    this.grid.forEach( function (row) {
      row.push(new Array(Snake.BOARDSIZE));
    });

  };

  Board.prototype.render = function () {
    var that = this;

    this.grid.forEach(function(row) {
      row.forEach(function(el) {
        el = ".";
      });
    });

    this.snake.segments.forEach(function(segment) {
      var x = segment[0];
      var y = segment[1];
      that.grid[x][y] = "s";
    });
  };
})();


  function Game() {
    this.board = new S.Board();
    this.snake = this.board.snake;
  };

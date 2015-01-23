(function () {
  if (typeof S === "undefined") {
    window.S = {};
  }

  var View = S.View = function (game, $el) {
    this.game = new Game();
    this.$el = $el;
  };

  // View.prototype.bindEvents = function () {
  //   var that = this;
  //   this.$el.on('click', '.sq', function () {
  //     var $sq = $(this);
  //     var id = parseInt($sq.attr('id'));
  //     var x = Math.floor(id / 3);
  //     var y = id % 3;
  //     if (that.game.board.isEmptyPos([x, y])) {
  //       that.makeMove($sq);
  //       that.game.playMove([x, y]);
  //     }
  //     if (that.game.isOver()) {
  //       that.$el.after($('<div class="game-over">game over!</div>'));
  //       that.$el.off('click');
  //     }
  //   });
  // };

  // View.prototype.makeMove = function ($square) {
  //   $square.css('background-color', '#eee');
  //   var mark = this.game.currentPlayer;
  //   var $span = $('<span class="' + mark + '-mark">' + mark + '</span>');
  //   $square.append($span);
  // };

  View.prototype.render = function () {
    $(".snake").remove();
    var segments = this.game.snake.segments;
    segments.forEach(function(segment) {
      $('#' + (segment[1] + S.Snake.BOARDSIZE * segment[0]))
      .append($('<div class="snake"></div>'));
    });
  };

  View.prototype.setupBoard = function () {
    for(var i = 0; i < Math.pow(S.Snake.BOARDSIZE, 2); i++) {
      var $div = $("<div id=" + i + " class='sq'>");
      this.$el.append($div);
    }

    this.bindKeyHandlers();
  };

  View.prototype.bindKeyHandlers = function () {
    // define short of 'a'
    var that = this;
    key('a', function(){
      that.game.snake.dir = [0, -1];
      that.game.snake.move();
      that.render();
    });
    key('d', function(){
      that.game.snake.dir = [0, 1];
      that.game.snake.move();
      that.render();
    });
    key('w', function(){
      that.game.snake.dir = [-1, 0];
      that.game.snake.move();
      that.render();
    });
    key('s', function(){
      that.game.snake.dir = [1, 0];
      that.game.snake.move();
      that.render();
    });
  };
})();

(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = new Game();
    this.$el = $el;
  };

  View.prototype.bindEvents = function () {
    var that = this;
    this.$el.on('click', '.sq', function () {
      var $sq = $(this);
      var id = parseInt($sq.attr('id'));
      var x = Math.floor(id / 3);
      var y = id % 3;
      if (that.game.board.isEmptyPos([x, y])) {
        that.makeMove($sq);
        that.game.playMove([x, y]);
      }
      if (that.game.isOver()) {
        that.$el.after($('<div class="game-over">game over!</div>'));
        that.$el.off('click');
      }
    });
  };

  View.prototype.makeMove = function ($square) {
    $square.css('background-color', '#eee');
    var mark = this.game.currentPlayer;
    var $span = $('<span class="' + mark + '-mark">' + mark + '</span>');
    $square.append($span);
  };

  View.prototype.setupBoard = function () {
    for(var i = 0; i < 9; i++) {
      var $div = $("<div id=" + i + " class='sq'>");
      this.$el.append($div);
    }
    this.bindEvents();
  };
})();

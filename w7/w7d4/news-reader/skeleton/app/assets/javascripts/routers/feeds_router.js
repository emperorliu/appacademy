NewsReader.Routers.Feeds = Backbone.Router.extend({
  routes: {
    "": "index",
    "feeds/:id": "show"
  },

  index: function (){
    var indexView = new NewsReader.Views.FeedsIndex();
    this._swapView(indexView);

    // $("#content").html(indexView.render().$el);
  },

  show: function (id){
    var feeds = window.f = this.collection = new NewsReader.Collections.Feeds();
    feeds.fetch({
      success: function () {
        var feed = this.collection.getOrFetch(id);
        var showView = new NewsReader.Views.FeedShow({ model: feed });
        this._swapView(showView);
        // $("#content").html(showView.render().$el);
      }.bind(this)
    });
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    $('#content').html(view.render().$el)
  }


});

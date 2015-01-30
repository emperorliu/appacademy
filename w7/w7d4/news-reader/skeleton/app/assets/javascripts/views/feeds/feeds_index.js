NewsReader.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  initialize: function(){
    this.collection = new NewsReader.Collections.Feeds();
    this.listenTo(this.collection,'destroy', this.render);
  },

  events: {
    "click button.delete": "destroy"
  },

  destroy: function (event) {
    var $btn = $(event.currentTarget);
    var feed = this.collection.get($btn.data('id'))
    feed.destroy()
  },

  render: function(){
    var feeds = this.collection;
    var view = this;
    feeds.fetch({
      success: function () {
      var content = view.template({ feeds: feeds });
      view.$el.html(content);
      }
    });

    return this;
  }

});

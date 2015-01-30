NewsReader.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],
  initialize: function () {
    this.listenTo(this.model, "sync ", this.render);
    this._subViews = [];
  },

  render: function(){
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    this.model.entries().each(function(entry){
      var entryView = new NewsReader.Views.FeedShowItem({ model: entry });
      this._subViews.push(entryView);
      this.$('ul').append(entryView.render().$el);
    }, this);

    return this;
  },

  remove: function () {
    this._subViews.forEach(function (sub) {
      sub.remove();
    }, this);
    this._subViews = [];
    Backbone.View.prototype.remove.call(this);
  },

  events: {
    "click button.refresh": "refresh"
  },

  refresh: function() {
    this.model.fetch({
      success: function () {
        console.log(this.model.entries().length);
      }.bind(this)
    })
  }
});

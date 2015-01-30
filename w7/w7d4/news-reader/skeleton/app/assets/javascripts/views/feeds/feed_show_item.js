NewsReader.Views.FeedShowItem = Backbone.View.extend({
  template: JST['feeds/show_item'],
  tagName: "li",

  render: function(){
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  },

  // initialize: function () {
  //   this.listenTo(this.model, 'zombie', function () {
  //     console.log("Brains");
  //   });
  // }
});

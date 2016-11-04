var MrelloApp = MrelloApp || {};

MrelloApp.view.Lists = Backbone.View.extend({
  initialize: function() {
    this.$el = $("#lists-container")
    this.lists = MrelloApp.data;
    this.renderLists();
  },
  renderLists: function() {
    this.$el.empty();
    this.lists.each(this.renderListView, this);
  },
  renderListView: function(list) {
    var listView = new MrelloApp.view.List({
                     model: list
                   });
    this.$el.append(listView.el);
  },
});
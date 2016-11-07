var MrelloApp = MrelloApp || {};

MrelloApp.view.Comments = Backbone.View.extend({
  events: {
  },
  initialize: function() {
    this.$el = $(this.el);
    this.render();
  },
  render: function() {
    this.$el.empty();
    this.collection.each(this.renderCommentView, this);
  },
  renderCommentView: function(comment, index) {
    var id = index + 1;
    var payload = comment.get("payload");
    var commentView = MrelloApp.templates.comment({
      payload: payload,
      id: id,
    })
    this.$el.append(commentView);
  },
});


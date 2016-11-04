// CommentView: 
// A subview of a card-edit view

// Subviews: 
// CommentView <-> EditCommentView

// Events CommentView:
// Click on Edit -> Swap for EditCommentView
// Click on Delete -> Remove this view

// Events EditCommentView:
// Click on Save -> Update comment and swap for CommentView
// Click on Cancel -> Swap for CommentView

var MrelloApp = MrelloApp || {};

MrelloApp.view.Comment = Backbone.View.extend({
  template: MrelloApp.templates.comment,
  tagName: "div",
  className: "comment",
  initialize: function() {
    this.render();
  },
  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});

 
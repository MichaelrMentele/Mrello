// CardView -> An atomic subview of a list view

// Subviews
// None

// Events
// Click on CardView -> Render cardedit modal view

var MrelloApp = MrelloApp || {};

MrelloApp.view.Card = Backbone.View.extend({
  template: MrelloApp.templates.card,
  tagName: "div",
  className: "list-card",
  attributes: {
    "draggable" : "true",
  },
  events: {
    "click .card" : "renderEditor",
  },
  initialize: function() {
    this.index = this.model.collection.indexOf(this.model)
    this.render();
    this.bindDragEvents();
  },
  bindDragEvents: function() {
    var self = this;
    this.$el.on("dragstart", function(ev) {
      console.log("Saving model being dragged...");
      MrelloApp.draggedObject = self.model;
    });

    this.$el.on("dragover", function(ev) {
      console.log("")
      MrelloApp.insertAt = self.index;
    });
  },
  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },
  renderEditor: function() {
    new MrelloApp.view.CardEditor({model: this.model});
  },
});


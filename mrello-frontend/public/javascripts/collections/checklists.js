var MrelloApp = MrelloApp || {};

MrelloApp.collection.Checklists = Backbone.Collection.extend({
  model: MrelloApp.model.Checklist,
});
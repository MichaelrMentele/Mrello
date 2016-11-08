var MrelloApp = MrelloApp || {};

MrelloApp.collection.Lists = Backbone.Collection.extend({
  
  url: '/api/v1/lists',
  model: MrelloApp.model.List,
  parse: function(response) {
    return response.lists;
  }
});
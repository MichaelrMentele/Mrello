var MrelloApp = MrelloApp || {};

MrelloApp.collection.Cards = Backbone.Collection.extend({
  model: MrelloApp.model.Card,
  parse: function(response) {
    return response.cards;
  }
});
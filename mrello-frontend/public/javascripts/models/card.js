var MrelloApp = MrelloApp || {};

MrelloApp.model.Card = Backbone.Model.extend({
  defaults: {
    title: "Card",
    description: "",
  },
  initialize: function(attributes) {
    console.log("New Card Created");
    this.set("comments", attributes.comments || new MrelloApp.collection.Comments());
    this.get("comments").parent = this;

    this.set("checklists", attributes.checklists || new MrelloApp.collection.Checklists());
    this.get("checklists").parent = this;

    // Look for the parent Lists' title and cache it for easy rendering
    if (this.collection) {
      this.set("listTitle", this.collection.parent.attributes.title);
    }
  }
});
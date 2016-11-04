// App -> lists -> list-1 -> cards -> card-1 -> ...
//                 list-n -> cards -> card-n -> comments    -> comment-n
//                                              checklists  -> checklist-n

// App Data:
// - A collection of lists

// Lists Data:
// - list constructor
// - models

// List Data:
// - An id
// - A title (string)
// - A collection of cards

// Cards data:
// - card constructor
// - models

var MrelloApp = {
  model: {},      // constructor namespace
  collection: {}, // constructor namespace
  view: {},       // constructor namespace
  templates: JST,
  init: function() {
    this.data = new this.collection.Lists(); // Implement persistent data
    this.render();
    this.bindEvents();   
  },
  render: function() {
    this.board = new this.view.Board();
  },
  bindEvents: function() {
    _.extend(this, Backbone.Events);
    
    // triggered by board view
    this.on("addList", function(listInfo) {
      this.data.add(new this.model.List(listInfo));
    }, this);
  }
}

                                 
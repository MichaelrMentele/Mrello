// BoardView: The main view that manages all other views and
// binds event to static DOM elements

// Subviews:
// Board -> Lists      

// Statically Included Views Managed by 'this' View:
// Searchbar
// AddList
// ListTitleEntry

// Events:
// On keyup Searchbar -> Filter lists views
// Click on Add List -> Swap for ListTitleEntryView
// Click add on ListTitleEntryView -> Create new list view and Swap for AddList view
// Click cancel on ListTitleEntryView -> Swap for Addlist view

MrelloApp.view.Board = Backbone.View.extend({
  el: "body", // Existing container on tag
  addListContainer: "#new-list-creator",
  addListMenu: MrelloApp.templates["add-list-menu"],
  addListButton: MrelloApp.templates["add-list-button"],
  events: {
    "click #new-list-creator .add-list" : "renderAddListMenu",
    "click #new-list-creator .button" : "addList",
    "click #new-list-creator .cancel" : "renderAddListButton",
    "keyup #search-bar input" : "searchCards",
  },
  initialize: function() {
    this.render();
    this.bindEvents();
  },
  bindEvents: function() {
    _.extend(this, Backbone.Events);
    this.listenTo(MrelloApp.data, 'add remove change', this.render);
    this.on("refreshSearch", this.searchCards);
  },
  render: function() {
    this.renderLists();
    this.renderAddListButton();
    this.searchCards();
  },
  renderLists: function() {
    new MrelloApp.view.Lists()
  },
  renderAddListButton: function(e) {
    if (e) { e.preventDefault(); }
    $(this.addListContainer).html(this.addListButton());
  },
  renderAddListMenu: function(e) {
    e.preventDefault();
    $(this.addListContainer).html(this.addListMenu());
    $(this.el).find("input").focus();
  },
  addList: function(e) {
    e.preventDefault();
    var title = $(this.addListContainer + " .title-input").val();
    if (title != "") {
      MrelloApp.trigger("addList", {title: title});
    }
  },
  searchCards: function() {
    console.log("searching...")
    var query = $("#search-bar input").val();
    $(".card").css({
      "background": "white",
      "box-shadow" : "none"
    });
    if (query) {
      $(".card:contains(" + query + ")").css({
        "background": "aqua",
        "box-shadow" : "4px 4px 4px #888888",
      })
    }
  }
});
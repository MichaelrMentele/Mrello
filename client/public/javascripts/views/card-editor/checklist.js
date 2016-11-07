// ChecklistView: 
// A subview of a card-edit view

// Subviews: 
// ChecklistView <-> EditChecklistView

// Events ChecklistView:
// Click on Edit -> Swap for EditChecklistView
// Click on Delete -> Remove this view

// Events EditChecklistView:
// Click on Save -> Update comment and swap for ChecklistView
// Click on Cancel -> Swap for ChecklistView

var MrelloApp = MrelloApp || {};

MrelloApp.view.Checklist = Backbone.View.extend({

});
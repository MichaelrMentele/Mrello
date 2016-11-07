this["JST"] = this["JST"] || {};

this["JST"]["add-list-button"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<div class=\"list-wrapper\"><a class=\"add-list\" href=\"\">Add a list...</a></div>";
},"useData":true});

this["JST"]["add-list-menu"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<div class=\"list-wrapper\"><div class=\"list mod-add\"><input class=\"title-input\" type=\"text\" placeholder=\"Add a List...\"><a class=\"button\" href=\"#\">Save</a><a class=\"cancel\" href=\"#\"></a></div></div>";
},"useData":true});

this["JST"]["card-edit"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<div class=\"window-header\"><div class=\"card-title mod-window-heading\">"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + "<i class=\"glyphicon glyphicon-modal-window\"></i></div><div class=\"window-header-inline-content\"><span>In list </span><a class=\"open-in-header\" href=\"#\">"
    + alias4(((helper = (helper = helpers.listTitle || (depth0 != null ? depth0.listTitle : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"listTitle","hash":{},"data":data}) : helper)))
    + "</a></div><a class=\"cancel mod-window-cancel\" href=\"#\"></a></div><div class=\"card-details\"><span>Description </span><a class=\"open-in-header\" href=\"#\">edit</a><div class=\"card-description\">"
    + alias4(((helper = (helper = helpers.description || (depth0 != null ? depth0.description : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"description","hash":{},"data":data}) : helper)))
    + "</div></div><div class=\"window-column\"><div class=\"window-module add-comment-section\"><div class=\"window-module-header\"><div class=\"mod-window-heading\">Comments<i class=\"glyphicon glyphicon-comment\"></i></div></div><div class=\"module-content add-comment\"><textarea class=\"window-input comment-input-box\" placeholder=\"Write a comment...\"></textarea><input class=\"button submit-comment\" type=\"submit\" value=\"Add\"></div><div class=\"module-content comments\"></div></div><div class=\"window-module add-checklist-section\"><div class=\"window-module-header\"><div class=\"mod-window-heading\">Checklists<i class=\"glyphicon glyphicon-check\"></i></div></div><div class=\"module-content add-checklist\"><input class=\"window-input checklist-input-box\" placeholder=\"Write a checklist item...\"><input class=\"button submit-checklist-item\" type=\"submit\" value=\"Add\"></div><div class=\"module-content checklist\"></div></div></div>";
},"useData":true});

this["JST"]["checklist"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "";
},"useData":true});

this["JST"]["comment"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<div class=\"comment\">"
    + alias4(((helper = (helper = helpers.payload || (depth0 != null ? depth0.payload : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"payload","hash":{},"data":data}) : helper)))
    + "<i class=\"\">"
    + alias4(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"id","hash":{},"data":data}) : helper)))
    + "</i></div>";
},"useData":true});

this["JST"]["add-card-button"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<a class=\"add-card-button\">Add Card...</a>";
},"useData":true});

this["JST"]["add-card-menu"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<input class=\"title-input\" type=\"text\" placeholder=\"Add a Card...\"><a class=\"button\" href=\"#\">Add</a><a class=\"cancel\" href=\"#\"></a>";
},"useData":true});

this["JST"]["card"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<a class=\"card\"><div class=\"card-title\">"
    + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
    + "</div><div class=\"badges\"></div></a>";
},"useData":true});

this["JST"]["list-title"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<h3 class=\"list-title-heading\">"
    + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
    + "</h3>";
},"useData":true});

this["JST"]["list"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    return "<div class=\"list\"><div class=\"list-header\"><div class=\"list-title\"></div><a class=\"list-overflow-menu\" href=\"#\"><i class=\"glyphicon glyphicon-option-horizontal\"></i></a><div class=\"overflow-menu-container\"><ul class=\"overflow-menu-popup\"><li><a class=\".button delete\" href=\"#\">Delete</a></li></ul></div></div><div class=\"card-list\"></div><div class=\"add-card\"></div></div>";
},"useData":true});

this["JST"]["title-editor"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper;

  return "<input class=\"title-input\" value=\""
    + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
    + "\">";
},"useData":true});
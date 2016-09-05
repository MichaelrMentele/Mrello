this["JST"] = this["JST"] || {};

this["JST"]["category"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<!-- Subcategory --><!-- Title generated from todolist --><tr class=\"category\"><td><!-- Spacer --></td><td><a class=\"selectable\" href=\"#\">"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + "</a></td><td><span>"
    + alias4(((helper = (helper = helpers.todo_count || (depth0 != null ? depth0.todo_count : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"todo_count","hash":{},"data":data}) : helper)))
    + "</span></td></tr>";
},"useData":true});

this["JST"]["mainHeader"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<!-- Page Header --><!-- Title generated from category with class 'selected' of which there can only be one --><!-- Counts calculated from TodoList --><h1>"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + "</h1><span>"
    + alias4(((helper = (helper = helpers.todo_count || (depth0 != null ? depth0.todo_count : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"todo_count","hash":{},"data":data}) : helper)))
    + "</span>";
},"useData":true});

this["JST"]["modal"] = Handlebars.template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<!-- Modal: Todo Editor --><!-- Variables passed from Todo on TodoList --><div><ul><li><label><span>Title</span><input id=\"title_input\" type=\"text\" value=\""
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + "\" placeholder=\"Task Name\" /></label></li><li><label id=\"date_inputs\" class=\"date\"><span>Due Date</span><input type=\"number\" value=\""
    + alias4(((helper = (helper = helpers.day || (depth0 != null ? depth0.day : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"day","hash":{},"data":data}) : helper)))
    + "\" placeholder=\"Day\" min=\"0\" max=\"31\" /><span>/</span><input type=\"number\" value=\""
    + alias4(((helper = (helper = helpers.month || (depth0 != null ? depth0.month : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"month","hash":{},"data":data}) : helper)))
    + "\" placeholder=\"Month\" min =\"0\" max=\"12\" /><span>/</span><input type=\"number\" value=\""
    + alias4(((helper = (helper = helpers.year || (depth0 != null ? depth0.year : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"year","hash":{},"data":data}) : helper)))
    + "\" min=\"0\" placeholder=\"Year\" max=\"12\" /></label></li><li class=\"textbox\"><label><span>Description</span><textarea rows=\"4\" placeholder=\"Description\">"
    + alias4(((helper = (helper = helpers.description || (depth0 != null ? depth0.description : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"description","hash":{},"data":data}) : helper)))
    + "</textarea></label></li><li><input id=\"save_todo\" type=\"button\" value=\"Save\"><input id=\"save_and_complete_todo\" type=\"button\" value=\"Mark As Complete\"></li></ul></div>";
},"useData":true});

this["JST"]["todo"] = Handlebars.template({"1":function(container,depth0,helpers,partials,data) {
    return "checked";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1, helper, alias1=depth0 != null ? depth0 : {}, alias2=helpers.helperMissing, alias3="function", alias4=container.escapeExpression;

  return "<li data-id=\""
    + alias4(((helper = (helper = helpers.id || (depth0 != null ? depth0.id : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"id","hash":{},"data":data}) : helper)))
    + "\"><label class=\"control control-checkbox\"><input class=\"todo_toggle\" type=\"checkbox\" "
    + ((stack1 = helpers["if"].call(alias1,(depth0 != null ? depth0.complete : depth0),{"name":"if","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
    + "><span><a class=\"editable\" href=\"#\">"
    + alias4(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"title","hash":{},"data":data}) : helper)))
    + " &mdash; "
    + alias4(((helper = (helper = helpers.getCategory || (depth0 != null ? depth0.getCategory : depth0)) != null ? helper : alias2),(typeof helper === alias3 ? helper.call(alias1,{"name":"getCategory","hash":{},"data":data}) : helper)))
    + "</a></span><div class=\"control_indicator\"></div></label><a href=\"#deletable\"><img src=\"assets/trash_icon.png\"></img></a></li>";
},"useData":true});
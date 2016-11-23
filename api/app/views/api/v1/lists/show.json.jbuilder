json.message "List returned."

json.list do 
  json.partial! 'api/v1/lists/list', list: @list
end

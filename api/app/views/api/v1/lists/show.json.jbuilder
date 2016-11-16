json.message "SUCCESS"
json.status :ok

json.list do 
  json.partial! 'api/v1/lists/list', list: @list
end

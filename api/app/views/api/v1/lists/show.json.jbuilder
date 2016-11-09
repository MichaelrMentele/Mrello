json.message "SUCCESS"
json.status :ok

json.list do 
  json.partial! 'api/v1/lists/list', list: @list
end

json.cards do 
  json.array! @list.cards, partial: 'api/v1/cards/card', as: :card
end


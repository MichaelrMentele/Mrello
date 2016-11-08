json.message "SUCCESS"

json.list do
  json.extract! @list, :title
end

json.cards do 
  json.array! @list.cards, partial: 'api/v1/cards/card', as: :card
end

json.status :ok
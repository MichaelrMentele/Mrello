json.extract! list, :title, :id

json.cards do 
  json.array! list.cards, partial: 'api/v1/cards/card', as: :card
end


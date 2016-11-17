json.extract! list, :title, :id, :created_at, :updated_at

json.cards do 
  json.array! list.cards, partial: 'api/v1/cards/card', as: :card
end


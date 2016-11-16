json.message "SUCCESS"
json.status :ok

json.cards do
  json.array! @cards, partial: 'api/v1/cards/card', as: :card
end


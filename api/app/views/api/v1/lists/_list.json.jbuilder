json.extract! list, :title, :id, :created_at, :updated_at

# returning a cards object overwrites the cards collection saved on a list client side
# prefer to have each nested collection make its own request
# json.cards do 
#   json.array! list.cards, partial: 'api/v1/cards/card', as: :card
# end


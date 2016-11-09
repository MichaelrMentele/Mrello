json.message "SUCCESS"
json.status :ok

json.card do 
  json.partial! 'api/v1/cards/card', card: @card
end

json.comments do 
  json.array! @card.comments, partial: 'api/v1/comments/comment', as: :comment
end
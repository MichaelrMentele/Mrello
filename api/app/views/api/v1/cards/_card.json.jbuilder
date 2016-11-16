json.extract! card, :title, :id

json.comments do 
  json.array! card.comments, partial: 'api/v1/comments/comment', as: :comment
end
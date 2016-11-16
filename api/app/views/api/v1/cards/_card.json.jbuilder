json.extract! card, :title, :id, :created_at, :updated_at

json.comments do 
  json.array! card.comments, partial: 'api/v1/comments/comment', as: :comment
end
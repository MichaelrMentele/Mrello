json.message @message

json.join_requests do 
  json.array! @memberships, partial: 'api/v1/join_requests/membership', as: :membership
end

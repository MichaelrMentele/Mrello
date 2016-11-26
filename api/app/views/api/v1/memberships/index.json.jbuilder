json.message @message

json.memberships do 
  json.array! @memberships, partial: 'api/v1/join_requests/membership', as: :membership
end

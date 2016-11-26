json.message @message

json.memberships do 
  json.array! @memberships, partial: 'api/v1/memberships/membership', as: :membership
end

json.message @message

json.membership do 
  json.partial! 'api/v1/memberships/membership', membership: @membership
end

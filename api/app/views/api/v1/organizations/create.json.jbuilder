json.message @message

json.organization do
  json.partial! partial: 'api/v1/organizations/safe_organization'
end

json.user do 
  json.partial! partial: 'api/v1/users/safe_user'
end
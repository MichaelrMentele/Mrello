json.message @message
json.user do 
  json.partial! partial: 'api/v1/users/safe_user'
end
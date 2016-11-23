json.message @message
json.session_token @token
json.user do 
  json.partial! partial: 'api/v1/users/safe_user'
end

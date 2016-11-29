json.message @message
json.user do 
  json.partial! 'api/v1/users/safe_user'
end
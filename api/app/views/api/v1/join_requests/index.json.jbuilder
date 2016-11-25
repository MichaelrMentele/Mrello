json.message @message

json.join_requests do 
  json.array! @join_requests, partial: 'api/v1/join_requests/join_request', as: :join_request
end

json.extract! organization, :id, :admin_id, :title

json.join_requests do 
  json.array! organization.join_requests, partial: 'api/v1/join_requests/join_request', as: :join_request
end

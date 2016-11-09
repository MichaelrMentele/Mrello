json.message "SUCCESS"
json.status :ok

json.lists do
  json.array! @lists, partial: 'api/v1/lists/list', as: :list
end


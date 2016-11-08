json.message "SUCCESS"

json.lists do
  json.array! @lists, partial: 'api/v1/lists/list', as: :list
end

json.status :ok
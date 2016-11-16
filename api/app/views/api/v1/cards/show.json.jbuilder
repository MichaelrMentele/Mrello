json.message "SUCCESS: Card returned."
json.status :ok

json.card do 
  json.partial! 'api/v1/cards/card', card: @card
end


json.message @message

json.card do 
  json.partial! 'api/v1/cards/card', card: @card
end


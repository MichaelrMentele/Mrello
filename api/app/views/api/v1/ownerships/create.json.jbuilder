json.message @message

json.ownership do 
  json.partial! 'api/v1/ownerships/ownership', ownership: @ownership
end


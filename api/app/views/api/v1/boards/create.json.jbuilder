json.message @message

json.board do 
  json.partial! 'api/v1/lists/list', board: @board
end

json.message @message

json.board do 
  json.partial! 'api/v1/boards/board', board: @board
end

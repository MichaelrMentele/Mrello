json.message @message

json.boards do 
  json.array! @boards, partial: 'api/v1/boards/board', as: :board
end
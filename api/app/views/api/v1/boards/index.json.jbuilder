json.message @message

json.boards do 
  json.array! @boards, partial: 'api/v1/lists/list', as: :board
end
class Api::V1::ListsController < ApplicationController
  def create
    list = List.create(list_params)
    render json: 
      { status: "SUCCESS", message: "List created.", list: list },
      status: :ok
  end
end
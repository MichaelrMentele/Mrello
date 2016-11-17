class Api::V1::ListsController < Api::V1::ProtectedResourcesController
  
  def create
    @list = List.new(list_params.merge!(user_id: 1)) # TODO: USER ID SHOULD NOT BE HARDCODED BUT PASSED BY CLIENT
    if @list.save
      render json: {
        status: :ok,
        message: "SUCCESS: List created.", 
        list: @list 
      }
    else
      render json: {
        status: :not_acceptable, 
        message: "FAILURE: List not created. Invalid inputs." 
      }
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      render json: {
        status: :ok,
        message: "SUCCESS: List created.", 
        list: @list 
      }
    else
      render json: {
        status: :not_acceptable, 
        message: "FAILURE: List not created. Invalid inputs." 
      }
    end
  end

  def destroy
    # TODO refactor to only look in current users todos
    List.destroy(params[:id])
    render json: {
      message: "SUCCESS: List deleted.",
      status: :accepted
    }
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end 
end
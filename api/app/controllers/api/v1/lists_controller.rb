class Api::V1::ListsController < Api::V1::ProtectedResourcesController
  
  def create
    @list = List.new(list_params.merge!(user_id: 1)) # TODO: USER ID SHOULD NOT BE HARDCODED BUT PASSED BY CLIENT
    if @list.save
      render json: 
        { status: "SUCCESS", message: "List created.", list: @list },
        status: :ok
    else
      render json:
        { status: "FAILURE", message: "List not created. Invalid inputs." },
        status: :not_acceptable
    end
  end

  def update
    list = List.find(params[:id])
    binding.pry
    if list.update_attributes(list_params)
      render json: 
      { status: "SUCCESS", message: "List updated.", list: list },
        status: :ok
    else
      render json: 
      { status: "FAILURE", message: "List NOT updated.", list: list },
        status: :not_acceptable
    end
  end

  def destroy
    # TODO refactor to only look in current users todos
    List.destroy(params[:id])
    render json: 
      { status: "SUCCESS", message: "List deleted." },
      status: :accepted
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
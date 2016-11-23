class Api::V1::JoinRequestsController < ApplicationController
  def create
    @join_request = JoinRequest.new(request_params)
    if @join_request.save
      render json: {
        join_request: @join_request,
        message: "Request created."
      }, status: :created
    else
      render json: {
        message: "Request creation failed.",
      }, status: :not_acceptable
    end
  end

  def update
    @join_request = JoinRequest.find(params[:id])

    if @join_request.update_attributes(request_params) && @join_request.approved?

      @user = @join_request.user
      @user.update_attributes(organization_id: @join_request.user_id)

      render json: {
        join_request: @join_request,
        message: "Request approved. User has joined the organization."
      }, status: :accepted
    else
      render json: {
        message: "Request cannot be modified, only approved. Request update failed."
      }, status: :not_acceptable
    end
  end

  def index

  end

  private

  def request_params
    params.permit(:user_id, :organization_id, :approved)
  end
end
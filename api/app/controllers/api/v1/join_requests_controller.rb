class Api::V1::JoinRequestsController < ApplicationController
  before_action :authenticate_request

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

      # TODO: the user should not be updated here. Perhaps instead of join request I should have a membership that requires approval.
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
    # TODO: This seems like a design code smell--consider a membership instead
    if current_user.admin?
      @join_requests = current_user.organization.join_requests
      
      render json: {
        message: "Your organizations join requests.",
        join_requests: @join_requests
      }, status: :successful
    else
      @join_requests = current_user.join_requests
      render json: {
        message: "Your join requests.",
        join_requests: @join_requests
      }, status: :successful
    end
  end

  private

  def request_params
    params.permit(:user_id, :organization_id, :approved)
  end
end
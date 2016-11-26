class Api::V1::MembershipsController < ApplicationController
  before_action :authenticate_request

  def create
    @membership = Membership.new(request_params.to_h.merge(user_id: current_user.id))
    if @membership.save
      render json: {
        membership: @membership,
        message: "Request created."
      }, status: :created
    else
      render json: {
        message: "Request creation failed.",
      }, status: :not_acceptable
    end
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update_attributes(request_params) && @membership.approved?

      # TODO: the user should not be updated here. Perhaps instead of join request I should have a membership that requires approval.
      @user = @membership.user
      @user.update_attributes(organization_id: @membership.user_id)

      render json: {
        membership: @membership,
        message: "Request approved. User has joined the organization."
      }, status: :accepted
    else
      render json: {
        message: "Request cannot be modified, only approved. Request update failed."
      }, status: :not_acceptable
    end
  end

  def index
    if params[:organization_id]
      @organization = Organization.find(params[:organization_id])
      @message = "Rendering organizations join requests."
      @memberships = @organization.memberships
    else
      @message = "Rendering all join requests."
      @memberships = Membership.all
    end

    render :index, status: :ok
  end

  private

  def request_params
    params.permit(:user_id, :organization_id, :approved)
  end
end
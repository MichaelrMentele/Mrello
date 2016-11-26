class Api::V1::MembershipsController < ApplicationController
  before_action :authenticate_request

  def create
    @membership = Membership.new(membership_params.to_h.merge(user_id: current_user.id))
    if @membership.save
      @message = "Membership created."
      render :create, status: :created
    else
      @message = "Membership creation failed."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update_attributes(membership_params)
      @message = "Membership updated."
      render :update, status: :accepted
    else
      @message = "Update failed."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def index
    if membership_params[:organization_id]
      @organization = Organization.find(membership_params[:organization_id])
      @message = "Rendering organizations memberships."
      @memberships = @organization.memberships
    else
      @message = "Rendering users memberships."
      @memberships = current_user.memberships
    end

    render :index, status: :ok
  end

  private

  def membership_params
    params.permit(:user_id, :organization_id, :approved)
  end
end
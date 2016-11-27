class Api::V1::OwnershipsController < ApplicationController
  before_action :authenticate_request

  def create
    if owner?
      @ownership = Ownership.create(owner: owner)
      @message = "Ownership created."
      render :create, status: :created
    else
      @message = "No valid owner in params."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  private

  def ownership_params
    params.permit(:organization_id, :user_id)
  end

  def owner
    if ownership_params[:organization_id]
      Organization.find(ownership_params[:organization_id])
    elsif ownership_params[:user_id]
      User.find(ownership_params[:user_id])
    else
      nil
    end
  end

  def owner?
    !!owner
  end
end
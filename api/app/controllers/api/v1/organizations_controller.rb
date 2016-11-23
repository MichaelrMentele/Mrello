class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_request

  def create
    org = Organization.new(admin_id: current_user.id, title: params[:title])

    if current_user.admin? and current_user.no_organization? and org.save

      @org = org
      @message = "Organization created."
      render :create, status: :created

    else 

      if current_user.not_admin?
        status = :unauthorized
        @message = "You must be an admin to do that."
      elsif current_user.has_organization?
        status = :not_acceptable 
        @message = "You already have an organization."
      else
        status = :not_acceptable
        @message = "Organization not created."
      end

      render 'api/v1/shared/error', status: status

    end
  end

  def index
    organizations = Organization.all
    render json: {
      organizations: organizations,
      message: "Organizations retrieved."
    }, status: :ok
  end

end
class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_request

  def create
    org = Organization.new(admin_id: current_user.id, title: params[:title])
    if current_user.admin? and org.save
      # TODO: should associate the current user with the organization
      render json: { 
        message: "Your organization is created.", 
        organization: org
      }, status: :created
    else
      render json: {
        message: "Organization not created. Invalid inputs."
      }, status: :not_acceptable
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
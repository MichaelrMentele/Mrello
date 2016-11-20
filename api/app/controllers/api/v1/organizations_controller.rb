class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_request

  def create
    binding.pry
    user = User.find(params[:user_id])
    org = Organization.new(admin_id: params[:user_id], title: params[:title])
    if user.admin? and org.save
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
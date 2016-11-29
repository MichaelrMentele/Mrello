class Api::V1::OrganizationsController < ApplicationController
  before_action :authenticate_request

  def create
    # TODO: Refactor to use transactions to guarantee both organization 
    # and membership happen together.
    @organization = Organization.new(organization_params)
    if @organization.save
      @membership = Membership.create(
        organization: @organization, 
        user: current_user,
        approved: true
      )
      @message = "Organization created."
      render :create, status: :created
    else 
      @message = "Organization creation failed."
      render 'api/v1/shared/error', status: :not_acceptable
    end
  end

  def index
    if params[:user_id] 
      @organizations = User.find(params[:user_id]).organizations
      @message = "Users organizations retrieved."
    else
      @organizations = Organization.all
      @message = "All organizations retrieved."
    end

    render :index, status: :ok
  end

  def show
    @organization = Organization.find(params[:id])
    @message = "Organization retrieved."
    render :show, status: :ok
  end

  private

  def organization_params
    params.permit(:title)
  end
end
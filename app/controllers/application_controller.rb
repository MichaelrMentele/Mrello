class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  private

  attr_reader :current_user

  def authenticate_request
    @current_user = AuthenticateApiRequest.call(request.headers).result
    @message = "Not Authorized"
    render 'api/v1/shared/error', status: 401 unless @current_user
  end

  def check_access
    unless current_user.has_access_to(resource_type, params[:id])
      @message = "You do not have access to that resource."
      render 'api/v1/shared/error', status: :unauthorized
    end
  end

  private 

  def resource_type
    context.split("Controller")[0]
  end

  def context
    self.class.to_s.split("::").last
  end
end
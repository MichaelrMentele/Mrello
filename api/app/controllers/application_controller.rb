class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  private

  attr_reader :current_user

  def authenticate_request
    @current_user = AuthenticateApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  private

  def authenticate_request
    @current_user = AuthenticateApiRequest.call(request.headers).result

    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
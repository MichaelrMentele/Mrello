class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  helper_method :current_user, :user_logged_in?

  def current_user
    User.find(session[:user_id])
  end

  def user_logged_in?
    session[:user_id]
  end

  private

  def require_login
    render 'api/v1/protected_resources/require_login' unless user_logged_in?
  end
end

def set_current_user(user=nil)
  session[:user_id] = user.id
end

def sign_in(user=nil)
  post api_v1_login_path(id: user.id)
end
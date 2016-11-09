def set_current_user(user=nil)
  session[:user_id] = user.id
end

def sign_in(user=nil)
  # TODO
end
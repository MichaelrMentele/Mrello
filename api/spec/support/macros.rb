def sign_in(user=nil)
  post api_v1_sessions_path, params: { email: user.email, password: user.password }
end
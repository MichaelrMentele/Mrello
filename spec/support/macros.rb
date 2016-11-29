def sign_in(user=nil)
  post '/api/v1/sessions', params: { email: user.email, password: user.password }
end

def json 
  JSON.parse(response.body)
end
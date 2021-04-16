#spec/support/helpers/authentication
module LoginHelpers
  def login_as(user)
    post "/login", params: {  username: user[:username], password: user[:password] }
    payload = JSON.parse(response.body)
    payload["token"]
  end
end
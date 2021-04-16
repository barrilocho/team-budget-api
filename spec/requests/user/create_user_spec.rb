require "rails_helper"

RSpec.describe 'Users', type: :request do
  
  describe 'POST /users' do
    it "should create a user" do
      req_payload = {
        first_name: "Alejandro",
        last_name: "Barrios", 
        password: "lalal123",
        username: "alexba",
        email: "alejandro@aleate.com"
      }
      post "/users", params: req_payload
      payload = JSON.parse(response.body)
      user = payload['user'] 
      expect(payload).to_not be_empty
      expect(user['id']).to_not be_nil
    end
  end
end
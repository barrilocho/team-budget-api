require "rails_helper"

RSpec.describe "Families", type: :request do
  describe "POST /families" do
    let!(:user) { create(:user) }
    let!(:auth_headers) {
      credentials = {
        username: "#{user['username']}", 
        password: "test123"
      }
      token = login_as(credentials)
      { 'Authorization' => "Bearer #{token}"}
    }
    it "should create a family" do 
      req_payload = {
        family: {
          alias_name: "Barrios",
          code: "12345",
          members: 1,
          balance: 0
        }
      } 
      post "/families", params: req_payload, headers: auth_headers
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to_not be_nil
      expect(response).to have_http_status(:created)
    end
    it "should return error message on invalid family" do 
      req_payload = {
        family:{
          alias_name: "Barrios",
          members: 1,
          balance: 0
        }
      } 
      post "/families", params: req_payload, headers: auth_headers
      # post "/families", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
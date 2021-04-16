require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe 'POST /login' do
    let!(:user) {create(:user, password: 'lalala123')}
    it "should return success login with token" do
      req_payload = {
        username: user.username,
        password: "lalala123"
      }
      post "/login", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["token"]).to_not be_nil
      expect(payload["user"]).to_not be_nil
      expect(response).to have_http_status(200)
    end
    
  end

end

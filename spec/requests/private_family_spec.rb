require "rails_helper"
require "byebug"
RSpec.describe "Families with authentication", type: :request do
  let!(:user_family) { create(:family) }
  let!(:other_user_family) { create(:family) }
  let!(:user) { create(:user, family_id: user_family.id) }
  let!(:other_user) { create(:user, family_id: other_user_family.id) }
  let!(:auth_headers) {
    credentials = {
      username: "#{user['username']}", 
      password: "test123"
    }
    token = login_as(credentials)
    { 'Authorization' => "Bearer #{token}"}
  }
  let!(:other_auth_headers) {
    credentials = {
      username: "#{other_user['username']}", 
      password: "test123"
    }
    token = login_as(credentials)
    { 'Authorization' => "Bearer #{token}"}
  }
  # Authorization: Bearer token
  describe "GET /families/{id}" do
    context "with valid auth" do
      context "when requisting user other's family" do
        before { get "/families/#{other_user_family.id}", headers: auth_headers }
        context "payload" do
          subject { payload }
          it { is_expected.to include(:error) }
        end
        context "response" do
          subject { response }
          it { is_expected.to have_http_status(:not_found) }
        end
      end
      context "when requisting user family" do
        before { get "/families/#{user_family.id}", headers: auth_headers }
        context "payload" do
          subject { payload }
          it { is_expected.to include(:id) }
        end
        context "response" do
          subject { response }
          it { is_expected.to have_http_status(:ok) }
        end
      end
    end
  end
  describe "POST /families" do
    
  end
  describe "PUT /families/{id}" do
    
  end

  private 
  
  def payload
    JSON.parse(response.body).with_indifferent_access
  end
end
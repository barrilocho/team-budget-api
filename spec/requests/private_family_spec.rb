require "rails_helper"

RSpec.describe "Families with authentication", type: :request do
  let!(:user_family) { create(:family) }
  let!(:other_user_family) { create(:family) }
  let!(:user) { create(:user, family_id: user_family.id) }
  let!(:other_user) { create(:user, family_id: other_user_family.id) }
  let!(:auth_headears) {{ 'Authorization' => "Bearer #{user.auth_token}"}}
  let!(:other_auth_headears) {{ 'Authorization' => "Bearer #{user.auth_token}"}}
  # Authorization: Bearer token
  describe "GET /families/{id}" do
    context "with valid auth" do
      context "when requisting user other's family" do
        before { get "/families/#{other_user_family.id}", headers: auth_headears }
        context "payload" do
          subject { payload }
          it { is_expected.to include(:id) }
        end
        context "response" do
          subject { response }
          it { is_expected.to have_http_status(:ok) }
        end
      end
      context "when requisting user family" do
        
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
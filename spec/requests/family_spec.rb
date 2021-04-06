require "rails_helper"
require "byebug"

RSpec.describe 'Families', type: :request do

  describe 'GET /families' do
    let!(:families) { create_list(:family, 10) }
    before { get '/families' }
    it 'should return OK' do 
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end
  end
  describe "with data in DB" do

    let!(:families) { create_list(:family, 10) }
    before { get '/families' }
    it "should return all the families" do  
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(families.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /families/{id}" do
    let!(:family) { create(:family) }
    it "should return a family" do  
      get "/families/#{family.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(family.id)
      expect(response).to have_http_status(200)
    end
  end
end
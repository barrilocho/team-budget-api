require "rails_helper"

RSpec.describe 'Families', type: :request do

  describe 'GET /families' do
    before { get '/families' }

    it 'should return OK' do 
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['api']).to eq('OK')
    end
  end
  describe "with data in DB" do

    let(:families) { create_list(:family, 10) }
    before { get '/families' }
    it "should return all the families" do  
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(families.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /family/{id}" do
    let(:family) { create_list(:family, 1) }

    it "should return a family" do  
      before { get "/family/#{family.id}" }
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to_be eq(family.id)
      expect(response).to have_http_status(200)
    end
  end
end
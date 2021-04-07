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
  describe "POST /families" do
    it "should create a family" do 
      req_payload = {
        family: {
          alias_name: "Barrios",
          code: "12345",
          members: 1,
          balance: 0
        }
      } 
      post "/families", params: req_payload
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
      post "/families", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "PUT /families/id" do
    let!(:family) {create(:family)}
    it "should update a family" do  
      req_payload = {
        family:{
          alias_name: "Barrios test",
          code: "12345678",
          members: 1,
          balance: 0
        }
      } 
      put "/families/#{family.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(family.id)
      expect(response).to have_http_status(:ok)
    end
    it "should return error message on invalid family update" do 
      req_payload = {
        family: {
          alias_name: nil,
          members: nil,
          balance: 0
        }
      } 
      put "/families/#{family.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
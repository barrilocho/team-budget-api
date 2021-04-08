require "rails_helper"
require "byebug"

RSpec.describe 'Categories', type: :request do

  describe 'GET /categories' do
    let!(:categories) { create_list(:category, 10) }
    
    it 'should return OK' do
      get '/categories'
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end
    describe  'Search' do
      let!(:family) { create(:family) }
      let!(:category_one) { create(:category_family, name: "Entretenimiento" ) }
      let!(:category_two) { create(:category_family, name: "Diversión", ) }
      let!(:category_three) { create(:category, name: "Entretenimiento") }
      
     
      it 'should filter categories by title and family' do
        
        get "/categories?family_id=#{family.id}"
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(payload.size).to eq(2)
        expect(payload.map {|p| p["id"]}.sort).to eq([category_one.id, category_two.id].sort)
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "with data in DB" do
    let!(:categories) { create_list(:category, 10) }
    before { get '/categories' }
    it "should return all the categories" do  
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(categories.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /categories/{id}" do
    let!(:category) { create(:category) }
    it "should return a category" do  
      get "/categories/#{category.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(category.id)
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /categories" do
    let!(:family) { create(:family) }
    it "should create a category" do 
      req_payload = {
        category: {
          name: "Entretenimiento",
          category_type: 1,
          family_id: family.id
        }
      } 
      post "/categories", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to_not be_nil
      expect(response).to have_http_status(:created)
    end
    it "should return error message on invalid category" do 
      req_payload = {
        category:{
          name: "Entretenimiento",
          category_type: 1
        }
      } 
      post "/categories", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "PUT /categories/id" do
    let!(:category) {create(:category)}
    it "should update a category" do  
      req_payload = {
        category:{
          name: "Diversión",
          category_type: 2
        }
      } 
      put "/categories/#{category.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(category.id)
      expect(response).to have_http_status(:ok)
    end
    it "should return error message on invalid category update" do 
      req_payload = {
        category: {
          name: "Diversión",
          category_type: nil
        }
      } 
      put "/categories/#{category.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
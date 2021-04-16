require "rails_helper"
require "byebug"

RSpec.describe 'Categories', type: :request do
  let!(:family) {create(:family)}
  let!(:user) { create(:user, family_id: family.id) }
  let!(:auth_headers) {
    credentials = {
      username: "#{user['username']}", 
      password: "test123"
    }
    token = login_as(credentials)
    { 'Authorization' => "Bearer #{token}"}
  }
  describe 'GET /categories' do
    let!(:categories) { create_list(:category, 5, family_id: family.id) }
    it 'should return OK' do
      get '/categories', headers: auth_headers
      payload = JSON.parse(response.body)
      
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end
    describe  'Search' do
      let!(:category_one) { create(:category, name: "Entretenimiento", family_id: family.id ) }
      let!(:category_two) { create(:category, name: "Diversión", family_id: family.id ) }
      let!(:category_three) { create(:category, name: "Entretenimiento") }
      let!(:category_three) { create(:category, name: "Otro") }
      let!(:category_three) { create(:category, name: "Otro mas") }

      it 'should filter categories by title and family' do
        get "/categories?family_id=#{family.id}", headers: auth_headers
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(payload.size).to eq(7)
        expect(payload.map {|p| p["id"]}.sort).to include(category_one.id, category_two.id)
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "with data in DB" do
    let!(:categories) { create_list(:category, 10, family_id: family.id) }
    before { get '/categories', headers: auth_headers }
    it "should return all the categories" do  
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(categories.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /categories/{id}" do
    let!(:category) { create(:category, family_id: family.id) }
    it "should return a category" do  
      get "/categories/#{category.id}", headers: auth_headers
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(category.id)
      expect(response).to have_http_status(200)
    end
  end
  describe "POST /categories" do
    let!(:family_post) { create(:family) }
    it "should create a category" do 
      req_payload = {
        category: {
          name: "Entretenimiento",
          category_type: 1,
          family_id: family_post.id
        }
      } 
      post "/categories", params: req_payload, headers: auth_headers
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to_not be_nil
      expect(response).to have_http_status(:created)
    end
    it "should return error message on invalid category" do 
      req_payload = {
        category:{
          category_type: 1
        }
      } 
      post "/categories", params: req_payload, headers: auth_headers
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  describe "PUT /categories/id" do
    let!(:category) {create(:category, family_id: user.family_id)}
    let!(:other_category) {create(:category)}
    it "should update a category" do  
      req_payload = {
        category:{
          name: "Diversión",
          category_type: 2
        }
      } 
      put "/categories/#{category.id}", params: req_payload, headers: auth_headers
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
      put "/categories/#{category.id}", params: req_payload,  headers: auth_headers
      payload = JSON.parse(response.body)
      puts payload
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "should return error message on invalid family_id for created category" do 
      req_payload = {
        category: {
          name: "Diversión",
          category_type: 1
        }
      } 
      put "/categories/#{other_category.id}", params: req_payload,  headers: auth_headers
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:not_found)
    end
  end
end
require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_params) { FactoryBot.attributes_for(:valid_login) }
  let(:invalid_params) { FactoryBot.attributes_for(:invalid_login) }
  
    def simulate_login
      post "/api/v1/login", params: { session: valid_params }
    end

  describe "POST /login" do

    it "logs in the user with valid parameters" do
      post "/api/v1/login", params: { session: valid_params }
      expect(JSON.parse(response.body)["message"]).to eq("Logged in successfully.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects user login with invalid parameters" do
      post "/api/v1/login", params: { session: invalid_params }
      expect(JSON.parse(body)["error"]).to eq("Invalid login credentials.")
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /logout" do
    it "logs out the authenticated user" do
      post "/api/v1/login", params: { session: valid_params }
      post "/api/v1/logout", headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(body)["message"]).to eq("Logged out successfully.")
      expect(response).to have_http_status(:ok)
    end
  end
end

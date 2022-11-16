require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }
  let(:invalid_login) { FactoryBot.attributes_for(:invalid_login_params) }

  describe "POST /login" do
    it "logs in the user with valid login" do
      post "/api/v1/login", params: { session: valid_login }
      expect(JSON.parse(response.body)["message"]).to eq("Logged in successfully.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects user login with invalid login" do
      post "/api/v1/login", params: { session: invalid_login }
      expect(JSON.parse(body)["error"]).to eq("Invalid login credentials.")
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /logout" do
    it "logs out the authenticated user" do
      post "/api/v1/login", params: { session: valid_login }
      post "/api/v1/logout", headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(body)["message"]).to eq("Logged out successfully.")
      expect(response).to have_http_status(:ok)
    end
  end
end

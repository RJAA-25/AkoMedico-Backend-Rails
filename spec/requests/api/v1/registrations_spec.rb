require 'rails_helper'

RSpec.describe "Api::V1::Registrations", type: :request do
  let(:valid_params) { FactoryBot.attributes_for(:user) }
  let(:invalid_params) { FactoryBot.attributes_for(:user, password: nil) }

  describe "POST /register" do
    it "creates a user with valid parameters" do
      post "/api/v1/register", params: { register: valid_params }
      expect(JSON.parse(response.body)["message"]).to eq("A confirmation email has been sent to verify your account.")
      expect(response).to have_http_status(:created)
    end

    it "rejects user creation with invalid parameters" do
      post "/api/v1/register", params: { register: invalid_params }
      expect(JSON.parse(response.body)["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

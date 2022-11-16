require 'rails_helper'

RSpec.describe "Api::V1::Registrations", type: :request do
  let(:valid_register) { FactoryBot.attributes_for(:user) }
  let(:invalid_register) { FactoryBot.attributes_for(:user, password: nil) }

  describe "POST /register" do
    it "creates a user with valid register" do
      post "/api/v1/register", params: { register: valid_register }
      expect(JSON.parse(response.body)["message"]).to eq("A confirmation email has been sent to verify your account.")
      expect(response).to have_http_status(:created)
    end

    it "rejects user creation with invalid register" do
      post "/api/v1/register", params: { register: invalid_register }
      expect(JSON.parse(response.body)["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

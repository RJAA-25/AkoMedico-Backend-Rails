require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:valid_profile) { FactoryBot.attributes_for(:profile) }
  let(:invalid_profile) { FactoryBot.attributes_for(:profile, birth_date: nil) }

  describe "POST /create" do
    it "creates valid profile" do
      login_and_confirm(user)
      post "/api/v1/profiles/create", params: { profile: valid_profile }, headers: set_headers
      expect(json_response["message"]).to eq("Profile has been created.")
      expect(response).to have_http_status(:created)
    end

    it "rejects profile creation with invalid profile" do
      login_and_confirm(user)
      post "/api/v1/profiles/create", params: { profile: invalid_profile }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates with valid profile" do
      login_and_confirm(user)
      post "/api/v1/profiles/create", params: { profile: valid_profile }, headers: set_headers
      patch "/api/v1/profiles/update", params: { profile: valid_profile }, headers: set_headers
      expect(json_response["message"]).to eq("Profile has been updated.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects profile update with invalid profile" do
      login_and_confirm(user)
      post "/api/v1/profiles/create", params: { profile: valid_profile }, headers: set_headers
      patch "/api/v1/profiles/update", params: { profile: invalid_profile }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

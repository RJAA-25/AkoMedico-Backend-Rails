require 'rails_helper'

RSpec.describe "Api::V1::Conditions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:doctor) { FactoryBot.create(:doctor, user: user) }

  let(:valid_doctor) { FactoryBot.attributes_for(:doctor) }
  let(:invalid_doctor) { FactoryBot.attributes_for(:doctor, specialty: nil) }

  describe "POST /create" do
    it "creates doctor with valid doctor" do
      login_and_confirm(user)
      post "/api/v1/doctors/create", params: { doctor: valid_doctor }, headers: set_headers
      expect(json_response["message"]).to eq("Doctor has been added.")
      expect(response).to have_http_status(:created)
    end

    it "rejects doctor creation with invalid doctor" do
      login_and_confirm(user)
      post "/api/v1/doctors/create", params: { doctor: invalid_doctor }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates doctor with valid doctor" do
      login_and_confirm(user)
      patch "/api/v1/doctors/update/#{doctor.uid}", params: { doctor: valid_doctor }, headers: set_headers
      expect(json_response["message"]).to eq("Doctor has been updated.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects doctor update with invalid doctor" do
      login_and_confirm(user)
      patch "/api/v1/doctors/update/#{doctor.uid}", params: { doctor: invalid_doctor }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "removes doctor from user" do
      login_and_confirm(user)
      delete "/api/v1/doctors/destroy/#{doctor.uid}", headers: set_headers
      expect(json_response["message"]).to eq("Doctor has been removed.")
      expect(response).to have_http_status(:ok)
    end
  end
end
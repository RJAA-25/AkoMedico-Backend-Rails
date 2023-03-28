require 'rails_helper'

RSpec.describe "Api::V1::Consultations", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:consultation) { FactoryBot.create(:consultation, user: user) }

  let(:valid_consultation) { FactoryBot.attributes_for(:consultation) }
  let(:invalid_consultation) { FactoryBot.attributes_for(:consultation, diagnosis: nil) }

  describe "POST /create" do
    it "creates consultation with valid consultation" do
      login_and_confirm(user)
      post "/api/v1/consultations/create", params: { consultation: valid_consultation }, headers: set_headers(user)
      expect(json_response["message"]).to eq("Consultation has been added.")
      expect(response).to have_http_status(:created)
    end

    it "rejects consultation creation with invalid consultation" do
      login_and_confirm(user)
      post "/api/v1/consultations/create", params: { consultation: invalid_consultation }, headers: set_headers(user)
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe "PATCH /update" do
  #   it "updates consultation with valid consultation" do
  #     login_and_confirm(user)
  #     patch "/api/v1/consultations/update/#{consultation.uid}", params: { consultation: valid_consultation }, headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Consultation has been updated.")
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "rejects consultation update with invalid consultation" do
  #     login_and_confirm(user)
  #     patch "/api/v1/consultations/update/#{consultation.uid}", params: { consultation: invalid_consultation }, headers: set_headers(user)
  #     expect(json_response["errors"].size).to be > 0
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "removes consultation from user" do
  #     login_and_confirm(user)
  #     delete "/api/v1/consultations/destroy/#{consultation.uid}", headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Consultation has been removed.")
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end

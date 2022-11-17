require 'rails_helper'

RSpec.describe "Api::V1::Admissions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:admission) { FactoryBot.create(:admission, user: user) }

  let(:valid_admission) { FactoryBot.attributes_for(:admission) }
  let(:invalid_admission) { FactoryBot.attributes_for(:admission, diagnosis: nil) }

  describe "POST /create" do
    it "creates admission with valid admission" do
      login_and_confirm(user)
      post "/api/v1/admissions/create", params: { admission: valid_admission }, headers: set_headers
      expect(json_response["message"]).to eq("Admission has been added.")
      expect(response).to have_http_status(:created)
    end

    it "rejects admission creation with invalid admission" do
      login_and_confirm(user)
      post "/api/v1/admissions/create", params: { admission: invalid_admission }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates admission with valid admission" do
      login_and_confirm(user)
      patch "/api/v1/admissions/update/#{admission.uid}", params: { admission: valid_admission }, headers: set_headers
      expect(json_response["message"]).to eq("Admission has been updated.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects admission update with invalid admission" do
      login_and_confirm(user)
      patch "/api/v1/admissions/update/#{admission.uid}", params: { admission: invalid_admission }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "removes admission from user" do
      login_and_confirm(user)
      delete "/api/v1/admissions/destroy/#{admission.uid}", headers: set_headers
      expect(json_response["message"]).to eq("Admission has been removed.")
      expect(response).to have_http_status(:ok)
    end
  end
end

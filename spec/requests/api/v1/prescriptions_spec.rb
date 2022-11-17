require 'rails_helper'

RSpec.describe "Api::V1::Prescriptions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:consultation) { FactoryBot.create(:consultation, user: user) }
  # let(:admission) { FactoryBot.create(:admission, user: user) }

  let(:prescription) { FactoryBot.create(:prescription, prescription_issue: consultation) }
  # let(:prescription) { FactoryBot.create(:prescription, prescription_issue: admission) }


  valid_create = { issue: "consultation", upload: ["file_1", "file_2", "file_3"] }
  valid_update = { issue: "consultation", upload: ["file_4", "file_5"], remove: ["file_1"] }
  invalid_create_update = { issue: "consultation" }

  # valid_create = { issue: "admission", upload: ["file_1", "file_2", "file_3"] }
  # valid_update = { issue: "admission", upload: ["file_4", "file_5"], remove: ["file_1"] }
  # invalid_create_update = { issue: "admission" }
  
  describe "POST /create" do
    it "creates prescription with valid prescription" do
      login_and_confirm(user)
      post "/api/v1/prescriptions/create/#{consultation.uid}", params: { prescription: valid_create }, headers: set_headers
      expect(json_response["message"]).to eq("Prescriptions have been added.")
      expect(response).to have_http_status(:created) 
    end

    it "rejects prescription creation with invalid prescription" do
      login_and_confirm(user)
      post "/api/v1/prescriptions/create/#{consultation.uid}", params: { prescription: invalid_create_update }, headers: set_headers
      expect(json_response["error"]).to eq("Upload failed. Files are missing.")
      expect(response).to have_http_status(:unprocessable_entity) 
    end
  end

  describe "PATCH /update" do
    it "updates prescription with valid prescription" do
      login_and_confirm(user)
      patch "/api/v1/prescriptions/update/#{consultation.uid}", params: { prescription: valid_update }, headers: set_headers
      expect(json_response["message"]).to eq("Prescriptions have been updated.")
      expect(response).to have_http_status(:ok) 
    end

    it "rejects prescription update with invalid prescription" do
      login_and_confirm(user)
      patch "/api/v1/prescriptions/update/#{consultation.uid}", params: { prescription: invalid_create_update }, headers: set_headers
      expect(json_response["error"]).to eq("Update failed. Files are missing.")
      expect(response).to have_http_status(:unprocessable_entity) 
    end    
  end
end

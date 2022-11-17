require 'rails_helper'

RSpec.describe "Api::V1::Results", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:consultation) { FactoryBot.create(:consultation, user: user) }
  # let(:admission) { FactoryBot.create(:admission, user: user) }

  let(:result) { FactoryBot.create(:result, result_issue: consultation) }
  # let(:result) { FactoryBot.create(:result, result_issue: admission) }


  valid_create = { issue: "consultation", upload: ["file_1", "file_2", "file_3"] }
  valid_update = { issue: "consultation", upload: ["file_4", "file_5"], remove: ["file_1"] }
  invalid_create_update = { issue: "consultation" }

  # valid_create = { issue: "admission", upload: ["file_1", "file_2", "file_3"] }
  # valid_update = { issue: "admission", upload: ["file_4", "file_5"], remove: ["file_1"] }
  # invalid_create_update = { issue: "admission" }
  
  describe "POST /create" do
    it "creates result with valid result" do
      login_and_confirm(user)
      post "/api/v1/results/create/#{consultation.uid}", params: { result: valid_create }, headers: set_headers
      expect(json_response["message"]).to eq("Results have been added.")
      expect(response).to have_http_status(:created) 
    end

    it "rejects result creation with invalid result" do
      login_and_confirm(user)
      post "/api/v1/results/create/#{consultation.uid}", params: { result: invalid_create_update }, headers: set_headers
      expect(json_response["error"]).to eq("Upload failed. Files are missing.")
      expect(response).to have_http_status(:unprocessable_entity) 
    end
  end

  describe "PATCH /update" do
    it "updates result with valid result" do
      login_and_confirm(user)
      patch "/api/v1/results/update/#{consultation.uid}", params: { result: valid_update }, headers: set_headers
      expect(json_response["message"]).to eq("Results have been updated.")
      expect(response).to have_http_status(:ok) 
    end

    it "rejects result update with invalid result" do
      login_and_confirm(user)
      patch "/api/v1/results/update/#{consultation.uid}", params: { result: invalid_create_update }, headers: set_headers
      expect(json_response["error"]).to eq("Update failed. Files are missing.")
      expect(response).to have_http_status(:unprocessable_entity) 
    end    
  end
end

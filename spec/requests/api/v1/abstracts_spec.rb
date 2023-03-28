require 'rails_helper'

RSpec.describe "Api::V1::Abstracts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:admission) { FactoryBot.create(:admission, user: user) }

  valid_create = { upload: ["file_1", "file_2", "file_3"] }
  valid_update = { upload: ["file_4", "file_5"], remove: ["file_1"] }
  invalid_create_update = { upload: nil, remove: nil}

  # Requires media upload
  # describe "POST /create" do
  #   it "creates abstract with valid abstract" do
  #     login_and_confirm(user)
  #     post "/api/v1/abstracts/create/#{admission.uid}", params: { abstract: valid_create }, headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Abstract has been added.")
  #     expect(response).to have_http_status(:created)
  #   end

  #   it "rejects abstract creation with invalid abstract" do
  #     login_and_confirm(user)
  #     post "/api/v1/abstracts/create/#{admission.uid}", params: { abstract: invalid_create_update }, headers: set_headers(user)
  #     expect(json_response["error"]).to eq("Upload failed. Files are missing.")
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end

  # describe "PATCH /update" do
  #   it "updates abstract with valid abstract" do
  #     login_and_confirm(user)
  #     patch "/api/v1/abstracts/update/#{admission.uid}", params: { abstract: valid_update }, headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Abstract has been updated.")
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "rejects abstract update with invalid abstract" do
  #     login_and_confirm(user)
  #     patch "/api/v1/abstracts/update/#{admission.uid}", params: { abstract: invalid_create_update }, headers: set_headers(user)
  #     expect(json_response["error"]).to eq("Update failed. Files are missing.")
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end
end

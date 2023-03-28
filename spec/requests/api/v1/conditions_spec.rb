require 'rails_helper'

RSpec.describe "Api::V1::Conditions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:condition) { FactoryBot.create(:condition, user: user) }

  let(:valid_condition) { FactoryBot.attributes_for(:condition) }
  let(:invalid_condition) { FactoryBot.attributes_for(:condition, diagnosis: nil) }

  describe "POST /create" do
    it "creates condition with valid condition" do
      login_and_confirm(user)
      post "/api/v1/conditions/create", params: { condition: valid_condition }, headers: set_headers(user)
      expect(json_response["message"]).to eq("Condition has been added.")
      expect(response).to have_http_status(:created)
    end

    it "rejects condition creation with invalid condition" do
      login_and_confirm(user)
      post "/api/v1/conditions/create", params: { condition: invalid_condition }, headers: set_headers(user)
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe "PATCH /update" do
  #   it "updates condition with valid condition" do
  #     login_and_confirm(user)
  #     patch "/api/v1/conditions/update/#{condition.uid}", params: { condition: valid_condition }, headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Condition has been updated.")
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it "rejects condition update with invalid condition" do
  #     login_and_confirm(user)
  #     patch "/api/v1/conditions/update/#{condition.uid}", params: { condition: invalid_condition }, headers: set_headers(user)
  #     expect(json_response["errors"].size).to be > 0
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "removes condition from user" do
  #     login_and_confirm(user)
  #     delete "/api/v1/conditions/destroy/#{condition.uid}", headers: set_headers(user)
  #     expect(json_response["message"]).to eq("Condition has been removed.")
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end

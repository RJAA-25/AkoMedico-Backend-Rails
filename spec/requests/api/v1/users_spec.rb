require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:valid_email) { FactoryBot.attributes_for(:valid_email_params) }
  let(:invalid_email)  { FactoryBot.attributes_for(:valid_email_params, email: "invalid_email") }

  let(:valid_password) { FactoryBot.attributes_for(:valid_password_params) }
  let(:invalid_password) { FactoryBot.attributes_for(:valid_password_params, password: "12345") }
 
  describe "POST /update_email" do
    it "sends a confirmation email with valid email" do
      login_and_confirm(user)
      user.update(updated_at: DateTime.current - 1.hour)
      post "/api/v1/users/update-email", params: { user: valid_email }, headers: set_headers(user)
      expect(json_response["message"]).to eq("A confirmation email has been sent to your new email address. Please accomplish within the next 30 minutes to save your changes.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects email update when requested in sub-30-minute intervals" do
      login_and_confirm(user)
      post "/api/v1/users/update-email", params: { user: valid_email }, headers: set_headers(user)
      expect(json_response["error"]).to eq("Update request is limited to once every 30 minutes.")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "rejects email update with invalid email" do
      login_and_confirm(user)
      post "/api/v1/users/update-email", params: { user: invalid_email }, headers: set_headers(user)
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /update_password" do
    it "updates password with valid password" do
      login_and_confirm(user)
      post "/api/v1/users/update-password", params: { user: valid_password }, headers: set_headers(user)
      expect(json_response["message"]).to eq("Password has been updated successfully.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects password update with invalid password" do
      login_and_confirm(user)
      post "/api/v1/users/update-password", params: { user: invalid_password }, headers: set_headers(user)
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "removes user from the database" do
      login_and_confirm(user)
      delete "/api/v1/users/destroy", headers: set_headers(user)
      expect(json_response["message"]).to eq("Account has been removed.")
      expect(response).to have_http_status(:ok)
    end
  end
end


require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:valid_email) { FactoryBot.attributes_for(:valid_email_params) }
  let(:invalid_email)  { FactoryBot.attributes_for(:invalid_email_params) }

  let(:valid_password) { FactoryBot.attributes_for(:valid_password_params) }
  let(:invalid_password) { FactoryBot.attributes_for(:invalid_password_params) }
 
  describe "POST /update_email" do
    it "sends a confirmation email with valid email" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true, updated_at: DateTime.current - 1.hour)
      post "/api/v1/users/update-email", params: { user: valid_email }, headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(body)["message"]).to eq("A confirmation email has been sent to your new email address. Please accomplish within the next 30 minutes to save your changes.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects update when requested in sub-30-minute intervals" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true)
      post "/api/v1/users/update-email", params: { user: valid_email }, headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(body)["error"]).to eq("Update request is limited to once every 30 minutes.")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "reject update with invalid email" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true)
      post "/api/v1/users/update-email", params: { user: invalid_email }, headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(response.body)["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST /update_password" do
    it "updates password with valid password" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true)
      post "/api/v1/users/update-password", params: { user: valid_password }, headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(response.body)["message"]).to eq("Password has been updated successfully.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects update with invalid password" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true)
      post "/api/v1/users/update-password", params: { user: invalid_password }, headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(response.body)["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "removes user from the database" do
      post "/api/v1/login", params: { session: valid_login }
      user.update(email_confirmed: true)
      delete "/api/v1/users/destroy", headers: { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      expect(JSON.parse(response.body)["message"]).to eq("Account has been removed.")
      expect(response).to have_http_status(:ok)
    end
  end
end


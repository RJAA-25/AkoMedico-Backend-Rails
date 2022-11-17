require 'rails_helper'

RSpec.describe "Api::V1::EmergencyContacts", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }

  let(:emergency_contact) { FactoryBot.create(:emergency_contact, user: user) }

  let(:valid_emergency_contact) { FactoryBot.attributes_for(:emergency_contact) }
  let(:invalid_emergency_contact) { FactoryBot.attributes_for(:emergency_contact, full_name: nil) }


  describe "POST /create" do
    it "creates valid emergency contact" do
      login_and_confirm(user)
      post "/api/v1/emergency-contacts/create", params: { emergency_contact: valid_emergency_contact }, headers: set_headers
      expect(json_response["message"]).to eql("Emergency contact has been added.")
      expect(response).to have_http_status(:created) 
    end

    it "rejects emergency contact creation with invalid emergency contact" do
      login_and_confirm(user)
      post "/api/v1/emergency-contacts/create", params: { emergency_contact: invalid_emergency_contact }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /update" do
    it "updates emergency contact" do
      login_and_confirm(user)
      patch "/api/v1/emergency-contacts/update/#{emergency_contact.id}", params: { emergency_contact: valid_emergency_contact }, headers: set_headers
      expect(json_response["message"]).to eq("Emergency contact has been updated.")
      expect(response).to have_http_status(:ok)
    end

    it "rejects emergency contact update with invalid emergency contact" do
      login_and_confirm(user)
      patch "/api/v1/emergency-contacts/update/#{emergency_contact.id}", params: { emergency_contact: invalid_emergency_contact }, headers: set_headers
      expect(json_response["errors"].size).to be > 0
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "removes emergency contact from user" do
      login_and_confirm(user)
      delete "/api/v1/emergency-contacts/destroy/#{emergency_contact.id}", headers: set_headers
      expect(json_response["message"]).to eq("Emergency contact has been removed.")
      expect(response).to have_http_status(:ok)
    end
  end
end

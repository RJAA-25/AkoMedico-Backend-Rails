require 'rails_helper'

RSpec.describe "Api::V1::Confirmations", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:valid_login) { FactoryBot.attributes_for(:valid_login_params) }


  describe "GET /verify" do
    it "verifies account thru email confirmation" do
      token = JsonWebToken.encode({user_email: user.email}, 3.days.from_now)
      get "/api/v1/confirmations/verify?token=#{token}"
      expect(json_response["message"]).to eq("Email confirmed. Account has been verified.")
      expect(response).to have_http_status(:ok)
    end

    it "confirms that account is already verified" do
      user.update(email_confirmed: true)
      token = JsonWebToken.encode({user_email: user.email}, 3.days.from_now)
      get "/api/v1/confirmations/verify?token=#{token}"
      expect(json_response["message"]).to eq("Account has already been verified.")
      expect(response).to have_http_status(:accepted)
    end
  end

  describe "POST /resend" do
    it "sends another confirmation email" do
      login(user)
      post "/api/v1/confirmations/resend", headers: set_headers(user)
      expect(json_response["message"]).to eq("A confirmation email has been sent to verify your account.")
      expect(response).to have_http_status(:ok)
    end

    it "confirms that account is already verified" do
      login_and_confirm(user)
      post "/api/v1/confirmations/resend", headers: set_headers(user)
      expect(json_response["message"]).to eql("Account has already been verified.")
      expect(response).to have_http_status(:accepted)
    end
  end

  describe "GET /update_email" do
    it "updates account email" do
      token = JsonWebToken.encode({user_uid: user.uid, user_email: "new_valid@email.com"}, 30.minutes.from_now)
      get "/api/v1/confirmations/update-email?token=#{token}"
      expect(json_response["message"]).to eq("Email address has been updated.")
      expect(response).to have_http_status(:ok)
    end
  end
end

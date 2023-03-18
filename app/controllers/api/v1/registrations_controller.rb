class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_request
  skip_before_action :account_confirmed


  def create
    @user = User.new(register_params)
    uid = SecureRandom.alphanumeric
    if @user.valid?
      @client = Cloudinary::Client.new
      @client.create_folder(uid)
      @user.uid = uid
      @user.save
      payload = { user_email: @user.email }
      verify_token = JsonWebToken.encode(payload, 3.days.from_now)
      ConfirmationMailer.with(user: @user, token: verify_token).verify_account.deliver_now
      render json: { 
                      user: @user, 
                      verify_token: verify_token, 
                      message: "A confirmation email has been sent to verify your account."
                    },
                    status: :created
    else
      render json: { errors: @user.errors.messages },
                    status: :unprocessable_entity
    end
  end

  private

  def register_params
    params
      .require(:register)
      .permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

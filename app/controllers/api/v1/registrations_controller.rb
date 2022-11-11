class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_request

  def create
    @user = User.new(register_params)
    if @user.save
      # Create Google Drive folder - User
      # Create Google Drive folder - Consultations
      # Create Google Drive folder - Admissions
      payload = { user_email: @user.email }
      verify_token = JsonWebToken.encode(payload, 3.days.from_now)
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

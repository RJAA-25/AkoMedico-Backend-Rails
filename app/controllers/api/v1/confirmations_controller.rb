class Api::V1::ConfirmationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:verify]
  skip_before_action :authenticate_request, only: [:verify]
  skip_before_action :account_confirmed

  def verify
    token = params[:token]
    begin
      decoded = JsonWebToken.decode(token)
      @user = User.find_by(email: decoded[:user_email])
      raise ActiveRecord::RecordNotFound if !@user
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Record not found." },
                    status: :not_found
    rescue JWT::ExpiredSignature
      render json: { error: "Confirmation invalid. Token has expired." },
                    status: :unprocessable_entity
    rescue JWT::DecodeError
      render json: { error: "Token is invalid. Request new token." },
                    status: :unprocessable_entity
    else
      if @user.email_confirmed
        render json: { message: "Account has already been verified." },
                      status: :accepted
      else
        @user.update(email_confirmed: true)
        render json: { message: "Email confirmed. Account has been verified." },
                      status: :ok
      end
    end
  end

  def resend
    if @current_user.email_confirmed
      render json: { message: "Account has already been verified." },
                    status: :accepted
    else
      payload = { user_email: @current_user.email }
      verify_token = JsonWebToken.encode(payload, 3.days.from_now)
      render json: { 
                      verify_token: verify_token, 
                      message: "A confirmation email has been sent to verify your account."
                    },
                    status: :ok
    end
  end
end

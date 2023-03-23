class Api::V1::SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :account_confirmed

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      payload = {uid: @user.uid }
      exp = 7.days.from_now.to_i
      access_token = JsonWebToken.encode(payload, exp)
      # session[:user_uid] = @user.uid
      # set_csrf_cookie
      render json: {  
                      user: @user,
                      expiry: exp,
                      access_token: access_token,
                      message: "Logged in successfully.",
                      profile: @user.profile 
                    },
                    status: :ok
    else
      render json: { error: "Invalid login credentials." }, 
                    status: :unauthorized
    end
  end

  def destroy
    # session.delete(:user_uid)
    # cookies.delete("CSRF-TOKEN")
    @current_user = nil
    render json: { message: "Logged out successfully." },
                  status: :ok
  end

  private 

  def session_params
    params
      .require(:session)
      .permit(:email, :password)
  end
end

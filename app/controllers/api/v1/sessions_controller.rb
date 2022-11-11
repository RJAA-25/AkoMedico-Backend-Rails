class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_request, only: [:create]

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user&.authenticate(params[:session][:password])
      session[:user_uid] = @user.uid
      set_csrf_cookie
      render json: {  
                      email_confirmed: @user.email_confirmed,
                      message: "Logged in successfully." 
                    },
                    status: :ok
    else
      render json: { error: "Invalid login credentials." }, 
                    status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_uid)
    cookies.delete("CSRF-TOKEN")
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

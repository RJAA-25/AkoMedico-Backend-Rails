class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include JsonWebToken

  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken,with: :new_csrf_cookie

  before_action :authenticate_request
  before_action :account_confirmed

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end

  def new_csrf_cookie
    set_csrf_cookie
    render json: { message: "Request secured. Please try again." },
                  status: :unprocessable_entity
  end

  def authenticate_request
    @current_user ||= User.find_by(uid: session[:user_uid])
    unless @current_user
      render json: { message: "Please log in to continue." },
                    status: :unauthorized
    end
  end

  def account_confirmed
    unless @current_user.email_confirmed
      render json: { error: "Account needs to be confirmed to continue" }, status: :forbidden
    end
  end
end
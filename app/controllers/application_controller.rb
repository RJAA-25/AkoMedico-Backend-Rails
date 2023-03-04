class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include JsonWebToken
  include GoogleDrive

  before_action :authenticate_request
  before_action :account_confirmed

  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken,with: :new_csrf_cookie
  rescue_from ActiveRecord::RecordNotFound, with: :no_record_found

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end

  def new_csrf_cookie
    set_csrf_cookie
    render json: { error: "Request secured. Please try again." },
                  status: :bad_request
  end

  def no_record_found
    render json: { error: "Record not found." },
                  status: :not_found
  end

  def authenticate_request
    @current_user ||= User.find_by(uid: session[:user_uid])
    unless @current_user
      cookies.delete("CSRF-TOKEN")
      render json: { error: "Please log in to continue." },
                    status: :unauthorized
    end
  end

  def account_confirmed
    unless @current_user.email_confirmed
      render json: { error: "Account needs to be confirmed to continue" }, status: :forbidden
    end
  end
end
class ApplicationController < ActionController::API
  # include ActionController::Cookies
  # include ActionController::RequestForgeryProtection
  include JsonWebToken
  include Cloudinary

  before_action :authenticate_request
  before_action :account_confirmed

  # protect_from_forgery with: :exception
  # rescue_from ActionController::InvalidAuthenticityToken,with: :new_csrf_cookie
  rescue_from ActiveRecord::RecordNotFound, with: :no_record_found

  private

  # def set_csrf_cookie
  #   cookies["CSRF-TOKEN"] = { value: form_authenticity_token, domain: ENV["CLIENT_ADDRESS"], secure:  true}
  # end

  # def new_csrf_cookie
  #   set_csrf_cookie
  #   render json: { error: "Request secured. Please try again." },
  #                 status: :bad_request
  # end

  def no_record_found
    render json: { error: "Record not found." },
                  status: :not_found
  end

  def authenticate_request
    authorization = request.headers['Authorization']
    if authorization
      access_token = authorization.split(" ").last
      begin
        decoded = JsonWebToken.decode(access_token)
        @current_user = User.find_by(uid: decoded[:uid])
      rescue JWT::ExpiredSignature
        render json: { error: "Session has expired. Please log in to continue." },
                      status: :unauthorized

      rescue JWT::DecodeError
        render json: { error: "Access denied. Please log in to continue." },
                      status: :unauthorized
      end
    else
      render json: { error: "Please log in to continue." },
                    status: :unauthorized
    end
    # @current_user ||= User.find_by(uid: session[:user_uid])
    # unless @current_user
    #   cookies.delete("CSRF-TOKEN")
    #   render json: { error: "Please log in to continue." },
    #                 status: :unauthorized
    # end
  end

  def account_confirmed
    unless @current_user.email_confirmed
      render json: { error: "Account needs to be confirmed to continue" }, status: :forbidden
    end
  end
end
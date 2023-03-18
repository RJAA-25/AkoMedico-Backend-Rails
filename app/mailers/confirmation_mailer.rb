class ConfirmationMailer < ApplicationMailer

  def verify_account
    @user = params[:user]
    @url = "https://#{ENV["SERVER_ADDRESS"]}/api/v1/confirmations/verify?token=#{params[:token]}"
    mail(
          to: email_address_with_name(@user.email, full_name(@user)),
          subject: "AkoMedico: Confirmation"
        )
  end

  def resend_token
    @user = params[:user]
    @url = "https://#{ENV["SERVER_ADDRESS"]}/api/v1/confirmations/verify?token=#{params[:token]}"
    mail(
          to: email_address_with_name(@user.email, full_name(@user)),
          subject: "AkoMedico: Resend Confirmation"
        )
  end

  def update_email_address
    @user = params[:user]
    @new_email = params[:new_email]
    @url = "https://#{ENV["SERVER_ADDRESS"]}/api/v1/confirmations/update-email?token=#{params[:token]}"
    mail(
          to: email_address_with_name(@new_email, full_name(@user)),  
          subject: "AkoMedico: Update Email Address"
        )
  end

  private
  
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end

class Api::V1::UsersController < ApplicationController

  def update_email
    @current_user.email = params[:user][:email]
    if @current_user.email_changed?
      if @current_user.valid?
        if DateTime.current > @current_user.updated_at + 30.minutes
          @current_user.restore_email!
          @current_user.update(updated_at: DateTime.current)
          # Send Confirmation Email
          payload = { user_uid: @current_user.uid, user_email: params[:user][:email] }
          update_token = JsonWebToken.encode(payload, 30.minutes.from_now)
          render json: { 
                          update_token: update_token,
                          message: "A confirmation email has been sent to your new email address. Please accomplish within the next 30 minutes to save your changes." 
                        },
                        status: :ok
        else
          render json: { error: "Update request is limited to once every 30 minutes." },
                        status: :unprocessable_entity
        end
      else
        render json: { errors: @current_user.errors.messages },
                      status: :unprocessable_entity
      end
    else
      render json: { message: "No changes have been made." },
                    status: :ok
    end
  end

  def update_password
    if @current_user.update(user_params)
      render json: { message: "Password has been updated successfully." },
                    status: :ok
    else
      render json: { errors: @current_user.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    render json: { message: "Account has been removed." },
                  status: :ok
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation)
  end
end

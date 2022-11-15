class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_request
  skip_before_action :account_confirmed


  def create
    @user = User.new(register_params)
    if @user.save
      # @drive = GoogleDrive::Client.new
      # root_id = @drive.create_folder("akomedico_folder_id", @user.uid ).id
      # consultation_id = @drive.create_folder(root_id, "Consultations").id
      # admission_id = @drive.create_folder(root_id, "Admissions").id
      # @user.categories.create(name: "Root", folder_id: root_id)
      # @user.categories.create(name: "Consultations", folder_id: consultation_id)
      # @user.categories.create(name: "Admissions", folder_id: admission_id)

      # For Testing Purposes
      @user.categories.create(name: "Root", folder_id: SecureRandom.alphanumeric(10))
      @user.categories.create(name: "Consultations", folder_id: SecureRandom.alphanumeric(10))
      @user.categories.create(name: "Admissions", folder_id: SecureRandom.alphanumeric(10))
      
      # Send Confirmation Email
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

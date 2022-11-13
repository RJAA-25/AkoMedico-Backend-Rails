class Api::V1::ProfilesController < ApplicationController

  def create
    @profile = @current_user.build_profile(profile_params)
    if @profile.save
      render json: { 
                      profile: @profile,
                      message: "Profile has been created." 
                    },
                    status: :created
    else
      render json: { errors: @profile.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    @profile = @current_user.profile
    if @profile.update(profile_params)
      render json: { 
                      profile: @profile,
                      message: "Profile updated successfully." 
                    },
                    status: :ok
    else
      render json: { errors: @profile.errors.messages },
                    status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params
      .require(:profile)
      .permit(:birth_date, :address, :nationality, :civil_status, :contact_number, :height, :weight, :sex, :blood_type,)
  end
end

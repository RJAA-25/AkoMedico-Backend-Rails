class Api::V1::ProfilesController < ApplicationController

  def create
    @profile = @current_user.build_profile(profile_params)
    if @profile.valid?
      if image_file
        uid = SecureRandom.alphanumeric
        source = image_file.tempfile.to_io
        @client = Cloudinary::Client.new
        @profile.image_url = @client.upload_file(@current_user.uid, source, uid)
        @profile.uid = uid
      end
      @profile.save
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
    if @profile.valid?
      @profile.update(profile_params)
      if image_file
        uid = SecureRandom.alphanumeric
        source = image_file.tempfile.to_io
        @client = Cloudinary::Client.new
        if @profile.uid
          @client.delete_file("#{@current_user.uid}/#{@profile.uid}")
        end
        @profile.image_url = @client.upload_file(@current_user.uid, source, uid)
        @profile.uid = uid
      end
      @profile.save
      render json: { 
                      profile: @profile,
                      message: "Profile has been updated." 
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
      .permit(:birth_date, :address, :nationality, :civil_status, :contact_number, :height, :weight, :sex, :blood_type, :image_url)
  end

  def image_file
    profile_params.to_h["image_url"]
  end
end

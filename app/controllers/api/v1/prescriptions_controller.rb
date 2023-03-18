class Api::V1::PrescriptionsController < ApplicationController
  before_action :set_target

  def create
    if upload_files
      @client = Cloudinary::Client.new
      upload_files.each do |file|
        uid = SecureRandom.alphanumeric
        source = file.tempfile.to_io
        url = @client.upload_file("#{@current_user.uid}/#{@target.uid}", source, uid)
        upload_params = {
                                uid: uid,
                                image_url: url
                              }
        @target.prescriptions.create(upload_params)
      end
      target = @target.prescriptions
      render json: {
                      prescriptions: target,
                      message: "Prescriptions have been added." 
                    },
                    status: :created
    else
      render json: { error: "Upload failed. Files are missing."},
                    status: :unprocessable_entity
    end
  end

  def update
    if remove_files
      @client = Cloudinary::Client.new
      @prescriptions = @target.prescriptions
      remove_files.each do |uid|
        @client.delete_file("#{@current_user.uid}/#{@target.uid}/#{uid}")
        file = @prescriptions.find_by(uid: uid)
        file.destroy
      end
      target = @target.prescriptions
      render json: {
                      prescriptions: target,
                      message: "Prescriptions have been removed." 
                    },
                    status: :ok
    else
      render json: { error: "Removal failed. No files selected."},
                    status: :unprocessable_entity
    end
  end

  private

  def set_target
    case prescription_issue
    when "consultation"
      @target = Consultation.find_by(uid: params[:uid])
      no_record_found unless @target
    when "admission"
      @target = Admission.find_by(uid: params[:uid])
      no_record_found unless @target
    end
  end

  def prescription_params
    params
      .require(:prescription)
      .permit(:issue, upload: [], remove: [])
  end

  def prescription_issue
    prescription_params.to_h["issue"]
  end

  def upload_files
    prescription_params.to_h["upload"]
  end
  
  def remove_files
    prescription_params.to_h["remove"]
  end
end

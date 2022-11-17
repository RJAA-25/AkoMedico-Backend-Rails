class Api::V1::PrescriptionsController < ApplicationController
  before_action :set_target

  def create
    if upload_files
      render json: { message: "Prescriptions have been added." },
                      status: :created
    else
      render json: { error: "Upload failed. Files are missing."},
                    status: :unprocessable_entity
    end
  end

  def update
    if !upload_files && !remove_files
      render json: { error: "Update failed. Files are missing."},
                    status: :unprocessable_entity
    else
      render json: { message: "Prescriptions have been updated." },
                    status: :ok
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

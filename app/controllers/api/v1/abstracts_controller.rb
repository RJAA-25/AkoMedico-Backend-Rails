class Api::V1::AbstractsController < ApplicationController
  before_action :set_admission

  def create
    if upload_files
      render json: { message: "Abstract has been added." },
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
      render json: { message: "Abstract has been updated." },
                    status: :ok
    end
  end

  private

  def set_admission
    @admisison = Admission.find_by(uid: params[:uid])
    no_record_found unless @admisison
  end

  def abstract_params
    params
      .require(:abstract)
      .permit(upload: [], remove: [])
  end

  def upload_files
    abstract_params.to_h["upload"]
  end

  def remove_files
    abstract_params.to_h["remove"]
  end
end

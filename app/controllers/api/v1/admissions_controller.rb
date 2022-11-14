class Api::V1::AdmissionsController < ApplicationController
  include GoogleDrive

  before_action :set_admission, except: :create

  def create
    @admission = @current_user.admissions.build(admission_params)
    if @admission.valid?

      # @drive = GoogleDrive::Client.new
      # folder_id = @drive.create_folder(directory_id, @admission.diagnosis).id
      # @admission.folder_id = folder_id

      # For Testing Purposes
      @admission.folder_id = SecureRandom.alphanumeric(10)

      @admission.save
      render json: { 
                      admission: @admission,
                      message: "Admission has been added."
                    },
                    status: :created
    else
      render json: { errors: @admission.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    if @admission.update(admission_params)
      render json: {
                      admission: @admission,
                      message: "Admission has been updated."
                    },
                    status: :ok
    else
      render json: { errors: @admission.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @admission.destroy
    render json: { message: "Admission has been removed." },
                  status: :ok
  end

  private
  
  def set_admission
    @admission = Admission.find_by(uid: params[:uid])
    no_record_found unless @admission
  end

  def admission_params
    params
      .require(:admission)
      .permit(:diagnosis, :health_facility, :start_date, :end_date, :notes)
  end

  def directory_id
    @current_user.categories.find_by(name: "Admissions").folder_id
  end
end

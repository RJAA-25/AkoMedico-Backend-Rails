class Api::V1::AdmissionsController < ApplicationController
  before_action :set_admission, except: :create

  def create
    @admission = @current_user.admissions.build(admission_params)
    if @admission.valid?
      @drive = GoogleDrive::Client.new
      folder_id = @drive.create_folder(directory_id, @admission.diagnosis).id
      @admission.folder_id = folder_id
      @admission.save
      admit = JSON.parse(@admission.to_json)
      admit[:doctors] = @admission.doctor_ids
      admit[:prescriptions] = []
      admit[:results] = []
      admit[:abstracts] = []
      render json: { 
                      admission: admit,
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
      admit = JSON.parse(@admission.to_json)
      admit[:doctors] = @admission.doctor_ids
      admit[:prescriptions] = @admission.prescriptions
      admit[:results] = @admission.results
      admit[:abstracts] = @admission.abstracts
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
    @drive = GoogleDrive::Client.new
    admission_directory = @admission.folder_id
    @drive.delete_file(admission_directory)
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
      .permit(:diagnosis, :health_facility, :start_date, :end_date, :notes, doctor_ids: [])
  end

  def directory_id
    @current_user.categories.find_by(name: "Admissions").folder_id
  end
end

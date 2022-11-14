class Api::V1::ConsultationsController < ApplicationController
  before_action :set_consultation, except: :create
  
  def create
    @consultation = @current_user.consultations.build(consultation_params)
    if @consultation.valid?

      # @drive = GoogleDrive::Client.new
      # folder_id = @drive.create_folder(directory_id, @consultation.diagnosis).id
      # @consultation.folder_id = folder_id

      # For Testing Purposes
      @consultation.folder_id = SecureRandom.alphanumeric(10)

      @consultation.save
      render json: { 
                      consultation: @consultation,
                      message: "Consultation has been added."
                    },
                    status: :created
    else
      render json: { errors: @consultation.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    if @consultation.update(consultation_params)
      render json: {
                      consultation: @consultation,
                      message: "Consultation has been updated."
                    },
                    status: :ok
    else
      render json: { errors: @consultation.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @consultation.destroy
    render json: { message: "Consultation has been removed." },
                  status: :ok
  end

  private

  def set_consultation
    @consultation = Consultation.find_by(uid: params[:uid])
    no_record_found unless @consultation
  end
  
  def consultation_params
    params
      .require(:consultation)
      .permit(:diagnosis, :health_facility, :schedule, :notes)
  end
  
  def directory_id
    @current_user.categories.find_by(name: "Consultations").folder_id
  end
end

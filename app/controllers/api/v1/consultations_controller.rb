class Api::V1::ConsultationsController < ApplicationController
  before_action :set_consultation, except: :create
  
  def create
    @consultation = @current_user.consultations.build(consultation_params)
    if @consultation.valid?
      uid = SecureRandom.alphanumeric
      @client = Cloudinary::Client.new
      @client.create_folder("#{@current_user.uid}/#{uid}")
      @consultation.uid = uid
      @consultation.save
      consult = JSON.parse(@consultation.to_json)
      consult[:doctor_ids] = @consultation.doctor_ids
      consult[:prescriptions] = []
      consult[:results] = []
      render json: { 
                      consultation: consult,
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
      consult = JSON.parse(@consultation.to_json)
      consult[:doctor_ids] = @consultation.doctor_ids
      consult[:prescriptions] = @consultation.prescriptions
      consult[:results] = @consultation.results
      render json: {
                      consultation: consult,
                      message: "Consultation has been updated."
                    },
                    status: :ok
    else
      render json: { errors: @consultation.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @client = Cloudinary::Client.new
    @client.delete_folder("#{@current_user.uid}/#{@consultation.uid}")
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
      .permit(:diagnosis, :health_facility, :schedule, :notes, doctor_ids: [])
  end

  def directory_id
    @current_user.categories.find_by(name: "Consultations").folder_id
  end
end

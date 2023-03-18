class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor, except: :create

  def create
    @doctor = @current_user.doctors.build(doctor_params)
    if @doctor.valid?
      @doctor.uid = SecureRandom.alphanumeric
      @doctor.save
      render json: { 
                      doctor: @doctor,
                      message: "Doctor has been added."
                    },
                    status: :created
    else
      render json: { errors: @doctor.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    if @doctor.update(doctor_params)
      render json: { 
                    doctor: @doctor,
                    message: "Doctor has been updated."
                  },
                  status: :ok
    else
      render json: { errors: @doctor.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy
    render json: { message: "Doctor has been removed." },
                  status: :ok
  end

  private

  def set_doctor
    @doctor = Doctor.find_by(uid: params[:uid])
    no_record_found unless @doctor
  end

  def doctor_params
    params
      .require(:doctor)
      .permit(:first_name, :last_name, :specialty)
  end
end

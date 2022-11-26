class Api::V1::RequestsController < ApplicationController
  skip_before_action :account_confirmed, only: [:access]

  def access
    @user = User.includes(:profile).find(@current_user.id)
    @profile = @user.profile
    render json: {
                    user: @user,
                    profile: @profile
                  },
                  status: :ok

  end

  def overview
    @user = User.includes(:profile, :emergency_contacts, :conditions, :doctors, 
                            consultations: [:doctors, :prescriptions, :results], 
                            admissions: [:doctors, :prescriptions, :results, :abstracts])
              .find(@current_user.id)
    @profile = @user.profile
    @emergency_contacts = @user.emergency_contacts
    @conditions = @user.conditions
    @doctors = @user.doctors
    @consultations = @user.consultations
    consultations_arr = []
    @consultations.each do |consultation|
      consult = JSON.parse(consultation.to_json)
      consult[:doctors] = consultation.doctor_ids
      consult[:prescriptions] = consultation.prescriptions
      consult[:results] = consultation.results
      consultations_arr << consult
    end
    @admissions = @user.admissions
    admissions_arr = []
    @admissions.each do |admission|
      admit = JSON.parse(admission.to_json)
      admit[:doctors] = admission.doctor_ids
      admit[:prescriptions] = admission.prescriptions
      admit[:results] = admission.results
      admit[:abstract] = admission.abstracts
      admissions_arr << admit
    end
    render json: { 
                    user: @user,
                    profile: @profile,
                    contacts: @emergency_contacts,
                    conditions: @conditions,
                    doctors: @doctors,
                    consultations: consultations_arr,
                    admissions: admissions_arr
                  }, 
                  status: :ok
  end

  def profile
    @profile = @current_user.profile
    render json: {
                    profile: @profile
                  },
                  status: :ok
  end

  def doctors
    @doctors = @current_user.doctors
    render json: {
                    doctors: @doctors
                  },
                  status: :ok
  end

  def emergency_contacts
    @emergency_contacts  = @current_user.emergency_contacts
    render json: {
                    contacts: @emergency_contacts
                  },
                  status: :ok
  end

  def conditions
    @conditions = @current_user.conditions
    render json: {
                    conditions: @conditions
                  },
                  status: :ok
  end

  def consultations
    @consultations = Consultation.includes(:doctors, :prescriptions, :results)
                      .where(user: @current_user)
    consultations_arr = []
    @consultations.each do |consultation|
      consult = JSON.parse(consultation.to_json)
      consult[:doctors] = consultation.doctor_ids
      consult[:prescriptions] = consultation.prescriptions
      consult[:results] = consultation.results
      consultations_arr << consult
    end
    render json: {
                    consultations: consultations_arr
                  },
                  status: :ok
  end

  def admissions
    @admissions = Admission.includes(:doctors, :prescriptions, :results, :abstracts)
                    .where(user: @current_user)
    admissions_arr = []
    @admissions.each do |admission|
      admit = JSON.parse(admission.to_json)
      admit[:doctors] = admission.doctor_ids
      admit[:prescriptions] = admission.prescriptions
      admit[:results] = admission.results
      admit[:abstract] = admission.abstracts
      admissions_arr << admit
    end
    render json: {
                    admissions: admissions_arr
                  },
                  status: :ok
  end
end

class Api::V1::EmergencyContactsController < ApplicationController
  
  before_action :set_emergency_contact, except: :create

  def create
    @emergency_contact = @current_user.emergency_contacts.build(emergency_contact_params)
    if @emergency_contact.save
      render json: { 
                      emergency_contact: @emergency_contact,
                      messasge: "Emergency contact has been added."
                    },
                    status: :created
    else
      render json: { errors: @emergency_contact.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def update
    if @emergency_contact.update(emergency_contact_params)
      render json: { 
                    emergency_contact: @emergency_contact,
                    messasge: "Emergency contact has been updated."
                  },
                  status: :ok
    else
      render json: { errors: @emergency_contact.errors.messages },
                    status: :unprocessable_entity
    end
  end

  def destroy
    @emergency_contact.destroy
    render json: { message: "Emergency contact has been removed." },
                  status: :ok
  end

  private

  def set_emergency_contact
    @emergency_contact = @current_user.emergency_contacts.find(params[:id])
    raise Active::RecordNotFound unless @emergency_contact
  end

  def emergency_contact_params
    params
      .require(:emergency_contact)
      .permit(:full_name, :relationship, :contact_number)
  end
end

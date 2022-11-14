Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      # Registrations
      post "register" => "registrations#create"
      
      # Sessions
      post "login" => "sessions#create"
      post "logout" => "sessions#destroy" 

      # Confirmations
      get "confirmations/verify" => "confirmations#verify"
      post "confirmations/resend" => "confirmations#resend"
      get "confirmations/update-email" => "confirmations#update"

      # Users
      post "users/update-email" => "users#update_email"
      post "users/update-password" => "users#update_password"
      delete "users/destroy" => "users#destroy"

      # Profiles
      post "profiles/create" => "profiles#create"
      patch "profiles/update" => "profiles#update"
      
      # Emergency Contacts
      post "emergency-contacts/create" => "emergency_contacts#create"
      patch "emergency-contacts/update/:id" => "emergency_contacts#update"
      delete "emergency-contacts/destroy/:id" => "emergency_contacts#destroy"

      # Conditions
      post "conditions/create" => "conditions#create"
      patch "conditions/update/:id" => "conditions#update"
      delete "conditions/destroy/:id" => "conditions#destroy"

      # Consultations
      post "consultations/create" => "consultations#create"
      patch "consultations/update/:uid" => "consultations#update"
      delete "consultations/destroy/:uid" => "consultations#destroy"
    end
  end
end

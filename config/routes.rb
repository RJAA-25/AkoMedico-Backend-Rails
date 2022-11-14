Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      # Registrations
      post "register" => "registrations#create"
      
      # Sessions
      post "login" => "sessions#create"
      post "logout" => "sessions#destroy" 

      # Confirmations
      get "verify" => "confirmations#verify"
      post "resend" => "confirmations#resend"
      get "update-email" => "confirmations#update"

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
    end
  end
end

Rails.application.routes.draw do
  root "pages#root"
  
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
      get "confirmations/update-email" => "confirmations#update_email"

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

      # Doctors
      post "doctors/create" => "doctors#create"
      patch "doctors/update/:id" => "doctors#update"
      delete "doctors/destroy/:id" => "doctors#destroy"

      # Conditions
      post "conditions/create" => "conditions#create"
      patch "conditions/update/:id" => "conditions#update"
      delete "conditions/destroy/:id" => "conditions#destroy"

      # Consultations
      post "consultations/create" => "consultations#create"
      patch "consultations/update/:uid" => "consultations#update"
      delete "consultations/destroy/:uid" => "consultations#destroy"

      # Admissions
      post "admissions/create" => "admissions#create"
      patch "admissions/update/:uid" => "admissions#update"
      delete "admissions/destroy/:uid" => "admissions#destroy"

      # Prescriptions
      post "prescriptions/create/:uid" => "prescriptions#create"
      patch "prescriptions/update/:uid" => "prescriptions#update"

      # Results
      post "results/create/:uid" => "results#create"
      patch "results/update/:uid" => "results#update"

      # Abstracts
      post "abstracts/create/:uid" => "abstracts#create"
      patch "abstracts/update/:uid" => "abstracts#update"

      # Requests
      get "requests/access" => "requests#access"
      get "requests/overview" => "requests#overview"
      get "requests/profile" => "requests#profile"
      get "requests/doctors" => "requests#doctors"
      get "requests/emergency-contacts" => "requests#emergency_contacts"
      get "requests/existing-conditions" => "requests#conditions"
      get "requests/consultations" => "requests#consultations"
      get "requests/admissions" => "requests#admissions"
    end
  end
end

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

      #Profiles
      post "profiles/create" => "profiles#create"
      patch "profiles/update" => "profiles#update"
      
    end
  end
end

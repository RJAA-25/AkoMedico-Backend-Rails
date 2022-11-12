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

      # Users
      patch "user/update-email" => "users#update_email"
    end
  end
end

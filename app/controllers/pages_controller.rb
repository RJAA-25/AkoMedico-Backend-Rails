class PagesController < ApplicationController
  # skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_request
  skip_before_action :account_confirmed

  def root
    render json: {
                    title: "AkoMedico - Rails API",
                    description: "A lifestyle app that makes access to personal health information easy"
                  },
                  status: :ok
  end
end

class Api::V1::AbstractsController < ApplicationController
  before_action :set_admission

  def create
    if upload_files
      @client = Cloudinary::Client.new
      upload_files.each do |file|
        uid = SecureRandom.alphanumeric
        source = file.tempfile.to_io
        url = @client.upload_file("#{@current_user.uid}/#{@admission.uid}", source, uid)
        upload_params = {
                                uid: uid,
                                image_url: url
                              }
        @admission.abstracts.create(upload_params)
      end
      abstracts = @admission.abstracts
      render json: { 
                      abstracts: abstracts,
                      message: "Abstract has been added." },
                      status: :created
    else
      render json: { error: "Upload failed. Files are missing."},
                    status: :unprocessable_entity
    end
  end

  def update
    if remove_files
      @client = Cloudinary::Client.new
      @abstracts = @admission.abstracts
      remove_files.each do |uid|
        @client.delete_file("#{@current_user.uid}/#{@admission.uid}/#{uid}")
        file = @abstracts.find_by(uid: uid)
        file.destroy
      end
      abstracts = @admission.abstracts
      render json: {
                      abstracts: abstracts,
                      message: "Abstracts have been removed." 
                    },
                    status: :ok
    else
      render json: { error: "Removal failed. No files selected."},
                    status: :unprocessable_entity
    end
  end

  private

  def set_admission
    @admission = Admission.find_by(uid: params[:uid])
    no_record_found unless @admission
  end

  def abstract_params
    params
      .require(:abstract)
      .permit(upload: [], remove: [])
  end

  def upload_files
    abstract_params.to_h["upload"]
  end

  def remove_files
    abstract_params.to_h["remove"]
  end
end

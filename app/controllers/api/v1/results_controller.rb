class Api::V1::ResultsController < ApplicationController
  before_action :set_target

  def create
    if upload_files
      @client = Cloudinary::Client.new
      upload_files.each do |file|
        uid = SecureRandom.alphanumeric
        source = file.tempfile.to_io
        url = @client.upload_file("#{@current_user.uid}/#{@target.uid}", source, uid)
        upload_params = {
                                uid: uid,
                                image_url: url
                              }
        @target.results.create(upload_params)
      end
      target = @target.results
      render json: { 
                      results: target,
                      message: "Results have been added." 
                    },
                    status: :created
    else
      render json: { error: "Upload failed. Files are missing."},
                    status: :unprocessable_entity
    end
  end

  def update
    if remove_files
      @client = Cloudinary::Client.new
      @results = @target.results
      remove_files.each do |uid|
        @client.delete_file("#{@current_user.uid}/#{@target.uid}/#{uid}")
        file = @results.find_by(uid: uid)
        file.destroy
      end
      target = @target.results
      render json: {
                      results: target,
                      message: "Results have been removed." 
                    },
                    status: :ok
    else
      render json: { error: "Removal failed. No files selected."},
                    status: :unprocessable_entity
    end
  end

  private

  def set_target
    case result_issue
    when "consultation"
      @target = Consultation.find_by(uid: params[:uid])
      no_record_found unless @target
    when "admission"
      @target = Admission.find_by(uid: params[:uid])
      no_record_found unless @target
    end
  end

  def result_params
    params
      .require(:result)
      .permit(:issue, upload: [], remove: [])
  end

  def result_issue
    result_params.to_h["issue"]
  end

  def upload_files
    result_params.to_h["upload"]
  end

  def remove_files
    result_params.to_h["remove"]
  end
end

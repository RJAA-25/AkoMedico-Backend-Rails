class Api::V1::ResultsController < ApplicationController
  before_action :set_target

  def create
    @drive = GoogleDrive::Client.new
    if upload_files
      upload_files.each do |file|
        source = file.tempfile.to_io
        filename = file.original_filename
        upload_id = @drive.upload_file(@target.folder_id, filename, source).id
        @drive.file_access(upload_id)
        links = @drive.show_file(upload_id)
        upload_params = {
                                file_id: upload_id,
                                image_link: links[:image],
                                download_link: links[:download]
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
    @drive = GoogleDrive::Client.new
    if upload_files
      upload_files.each do |file|
        source = file.tempfile.to_io
        filename = file.original_filename
        upload_id = @drive.upload_file(@target.folder_id, filename, source).id
        @drive.file_access(upload_id)
        links = @drive.show_file(upload_id)
        upload_params = {
                                file_id: upload_id,
                                image_link: links[:image],
                                download_link: links[:download]
                              }
        @target.results.create(upload_params)
      end
    end
    if remove_files
      @results = @target.results
      remove_files.each do |file_id|
        @drive.delete_file(file_id)
        file = @results.find_by(file_id: file_id)
        file.destroy
      end
    end
    if !upload_files && !remove_files
      render json: { error: "Update failed. Files are missing."},
                    status: :unprocessable_entity
    else
      render json: { message: "Results have been updated." },
                    status: :ok
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

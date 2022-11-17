class Api::V1::AbstractsController < ApplicationController
  before_action :set_admission

  def create
    @drive = GoogleDrive::Client.new
    if upload_files
      upload_files.each do |file|
        source = file.tempfile.to_io
        filename = file.original_filename
        upload_id = @drive.upload_file(@dmission.folder_id, filename, source).id
        @drive.file_access(upload_id)
        links = @drive.show_file(upload_id)
        upload_params = {
                                file_id: upload_id,
                                image_link: links[:image],
                                download_link: links[:download]
                              }
        @admission.abstracts.create(upload_params)
      end
      render json: { message: "Abstract has been added." },
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
        upload_id = @drive.upload_file(@admission.folder_id, filename, source).id
        @drive.file_access(upload_id)
        links = @drive.show_file(upload_id)
        upload_params = {
                                file_id: upload_id,
                                image_link: links[:image],
                                download_link: links[:download]
                              }
        @admission.abstracts.create(upload_params)
      end
    end
    if remove_files
      @abstracts = @admission.abstracts
      remove_files.each do |file_id|
        @drive.delete_file(file_id)
        file = @abstracts.find_by(file_id: file_id)
        file.destroy
      end
    end
    if !upload_files && !remove_files
      render json: { error: "Update failed. Files are missing."},
                    status: :unprocessable_entity
    else
      render json: { message: "Abstract has been updated." },
                    status: :ok
    end
  end

  private

  def set_admission
    @admisison = Admission.find_by(uid: params[:uid])
    no_record_found unless @admisison
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

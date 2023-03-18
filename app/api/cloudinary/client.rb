require 'cloudinary'

module Cloudinary
  class Client

    def create_folder(folder_path)
      Cloudinary::Api.create_folder("development/#{folder_path}")
    end

    def delete_folder(folder_path)
      Cloudinary::Api.delete_resources_by_prefix("development/#{folder_path}")
      Cloudinary::Api.delete_folder("development/#{folder_path}")
    end

    def upload_file(folder_path, file, uid)
      Cloudinary::Uploader.upload(file, {public_id: uid, folder: "development/#{folder_path}"})["secure_url"]
    end

    def delete_file(folder_path)
      Cloudinary::Uploader.destroy("development/#{folder_path}")
    end
  end
  
end


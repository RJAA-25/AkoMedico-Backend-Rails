require 'cloudinary'

module Cloudinary
  class Client

    def create_folder(folder_path)
      Cloudinary::Api.create_folder("production/#{folder_path}")
    end

    def delete_folder(folder_path)
      Cloudinary::Api.delete_resources_by_prefix("production/#{folder_path}")
      Cloudinary::Api.delete_folder("production/#{folder_path}")
    end

    def upload_file(folder_path, file, uid)
      Cloudinary::Uploader.upload(file, {public_id: uid, folder: "production/#{folder_path}"})["secure_url"]
    end

    def delete_file(folder_path)
      Cloudinary::Uploader.destroy("production/#{folder_path}")
    end
  end
  
end


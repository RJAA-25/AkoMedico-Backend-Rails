module GoogleDrive
  class Client
    AUTHORIZED_DRIVE = Request.connection

    def create_folder(parent_id, folder_name)
      metadata = { name: folder_name, parents: [parent_id], mime_type: "application/vnd.google-apps.folder" }
      res = AUTHORIZED_DRIVE.create_file(metadata)
    end

    def upload_file(parent_id, file_name, source)
      metadata = { name: file_name, parents: [parent_id] }
      res = AUTHORIZED_DRIVE.create_file(metadata, upload_source: source)
    end

    def file_access(file_id)
      permission = { role: "reader", type: "anyone" }
      res = AUTHORIZED_DRIVE.create_permission(file_id, permission)
    end

    def show_file(file_id)
      view_link = "https://drive.google.com/uc?export=view&id=#{file_id}"
      content_link = "https://drive.google.com/uc?export=download&id=#{file_id}"
      links = { image: view_link, download: content_link }
    end

    def delete_file(file_id)
      drive.delete_file(file_id)
    end
  end
end
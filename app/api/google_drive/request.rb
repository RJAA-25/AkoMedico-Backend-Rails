require 'googleauth'
require 'google/apis/drive_v3'

module GoogleDrive
  class Request
    
    def self.authorization
      scopes = ["https://www.googleapis.com/auth/drive"]
      auth = Google::Auth.get_application_default(scopes)
      auth.fetch_access_token!
      return auth
    end

    def self.connection
      drive = Google::Apis::DriveV3::DriveService.new
      drive.authorization = authorization
      return drive
    end
  end
end
include JsonWebToken

module Helpers
  module Utility
    def json_response
      JSON.parse(response.body)
    end

    def set_headers(user)
      payload = { uid: user.uid }
      token = JsonWebToken.encode(payload)
      # { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
      { "Authorization" => "Bearer #{token}"}
    end
  end
end
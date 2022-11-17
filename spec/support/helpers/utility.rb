module Helpers
  module Utility
    def json_response
      JSON.parse(response.body)
    end

    def set_headers
      { "X-CSRF-Token" => cookies["CSRF-TOKEN"] }
    end
  end
end
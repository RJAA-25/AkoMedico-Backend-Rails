module Helpers
  module Authentication
    def login(user)
      post "/api/v1/login", params: { session: valid_login }
    end

    def login_and_confirm(user)
      login(user)
      user.update(email_confirmed: true)
    end
  end
end
class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("akomedico@gmail.com", "AkoMedico")
  layout "mailer"
end

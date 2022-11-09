class User < ApplicationRecord
  has_secure_password

  has_one :profile
  has_many :emergency_contacts
  has_many :conditions
  has_many :doctors
  has_many :consultations
  has_many :admssions

  before_validation do
    self.first_name = format_name(first_name) if first_name
    self.last_name = format_name(last_name) if last_name
  end

  before_create do
    self.uid = SecureRandom.alphanumeric(10).upcase
    self.email = email.downcase
    self.email_confirmed = false
  end

  before_update do
    self.email_confirmed = false if self.email_changed?
  end
  
  validates :first_name, 
                  presence: true
  validates :last_name, 
                  presence: true
  validates :email, 
                  presence: true, 
                  uniqueness: true,
                  format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, 
                  length: { in: 6..20 },
                  if: :target_password?

  private

  def target_password?
    self.password_digest_changed?
  end

  def format_name(name)
    name.split(" ").each { |word| word.capitalize! }.join(" ")
  end
end

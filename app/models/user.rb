class User < ApplicationRecord
  has_secure_password

  has_one :profile, dependent: :destroy
  has_many :emergency_contacts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :conditions, dependent: :destroy
  has_many :doctors, dependent: :destroy
  has_many :consultations, dependent: :destroy
  has_many :admissions, dependent: :destroy

  before_validation do
    self.first_name = format_name(first_name) if first_name
    self.last_name = format_name(last_name) if last_name
  end

  before_create do
    self.uid = SecureRandom.alphanumeric(10).upcase
    self.email = email.downcase
    self.email_confirmed = false
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
                  if: :password_changed?

  private

  def password_changed?
    password_digest_changed?
  end

  def format_name(name)
    name.split(" ").each { |word| word.capitalize! }.join(" ")
  end
end

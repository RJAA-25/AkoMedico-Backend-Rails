class EmergencyContact < ApplicationRecord
  belongs_to :user

  before_validation do
    self.contact_number = format_contact_number if contact_number
  end

  validates :full_name,
                  presence: true
  validates :relationship,
                  presence: true
  validates :contact_number,
                  presence: true,
                  length: { in: 11..13,
                    message: "Invalid format." }

  private

  def format_contact_number
    self.contact_number.gsub(/\s/, "")
  end
end

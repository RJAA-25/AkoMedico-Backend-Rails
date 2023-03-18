class Profile < ApplicationRecord
  belongs_to :user

  before_validation do
    self.contact_number = format_contact_number if contact_number
    self.address = format_address if address
  end

  validates :birth_date,
                  presence: true,
                  comparison: { less_than_or_equal_to: 18.years.ago,
                    message: "You must be at least 18 years old to continue." }
  validates :address,
                  presence: true
  validates :nationality,
                  presence: true
  validates :civil_status,
                  presence: true,
                  inclusion: { in: ["Single", "Married", "Divorced", "Separated", "Widowed"] }
  validates :contact_number,
                  presence: true,
                  length: { in: 7..15,
                    message: "Invalid format." }
  validates :height,
                  presence: true,
                  comparison: { greater_than: 0 }
  validates :weight,
                  presence: true,
                  comparison: { greater_than: 0 }
  validates :sex,
                  presence: true,
                  inclusion: { in: ["Male", "Female"] }
  validates :blood_type,
                  presence: true,
                  inclusion: { in: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"] }
  
  private

  def format_address
    self.address
      .gsub(",", ", ")
      .split(" ").each { |word| word.capitalize! }
      .join(" ")
  end

  def format_contact_number
    self.contact_number.gsub(/\s/, "")
  end
end

class Consultation < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :doctors
  has_many :prescriptions, as: :prescription_issue, dependent: :destroy
  has_many :results, as: :result_issue, dependent: :destroy

  before_validation do
    self.health_facility = format_facility if health_facility
  end

  before_create do
    self.uid = SecureRandom.alphanumeric(12)
  end

  validates :diagnosis,
                  presence: true
  validates :health_facility,
                  presence: true
  validates :schedule,
                  presence: true,
                  comparison: { less_than_or_equal_to: Date.current }
  validates :notes,
                  allow_nil: true,
                  length: { maximum: 1000 }
  
  private

  def format_facility
    self.health_facility
      .gsub(",", ", ")
      .split(" ").each { |word| word.capitalize! }
      .join(" ")
  end
end

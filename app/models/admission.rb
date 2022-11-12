class Admission < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :doctors
  has_many :prescriptions, as: :prescription_issue, dependent: :destroy
  has_many :results, as: :result_issue, dependent: :destroy
  has_one :abstract, dependent: :destroy

  before_validation do
    self.health_facility = format_facility if health_facility
  end

  before_create do
    self.uid = SecureRandom.alphanumeric(10).upcase
  end

  validates :uid,
                  presence: true,
                  uniqueness: true,
                  length: { is: 10 },
                  on: :create
  validates :folder_id,
                  presence: true
  validates :diagnosis,
                  presence: true
  validates :health_facility,
                  presence: true
  validates :start_date,
                  presence: true,
                  comparison: { less_than_or_equal_to: Date.current }
  validates :end_date,
                  presence: true,
                  comparison: { greater_than: :start_date, less_than_or_equal_to: Date.current }
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

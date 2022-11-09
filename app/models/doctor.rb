class Doctor < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :consultations
  has_and_belongs_to_many :admissions

  before_validation do
    self.first_name = format_name(first_name) if first_name
    self.last_name = format_name(last_name) if last_name
    self.specialty = format_name(specialty) if specialty
  end

  validates :first_name,
                  presence: true
  validates :last_name,
                  presence: true
  validates :specialty,
                  presence: true
  
  private

  def format_name(name)
    name.split(" ").each { |word| word.capitalize! }.join(" ")
  end
end

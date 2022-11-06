class Doctor < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :consultations
  has_and_belongs_to_many :admissions
end

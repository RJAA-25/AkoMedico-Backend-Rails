class Consultation < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :doctors
  has_many :prescriptions, as: :prescription_issue
  has_many :results, as: :result_issue
end

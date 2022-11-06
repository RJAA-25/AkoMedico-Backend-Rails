class Prescription < ApplicationRecord
  belongs_to :prescription_issue, polymorphic: true
end

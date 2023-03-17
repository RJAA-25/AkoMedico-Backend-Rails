class Prescription < ApplicationRecord
  belongs_to :prescription_issue, polymorphic: true
  
  validates :image_url,
                  presence: true
end

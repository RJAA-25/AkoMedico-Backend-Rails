class Prescription < ApplicationRecord
  belongs_to :prescription_issue, polymorphic: true
  
  validates :file_id,
                  presence: true
  validates :image_link,
                  presence: true
  validates :download_link,
                  presence: true
end

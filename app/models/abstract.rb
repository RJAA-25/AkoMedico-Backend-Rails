class Abstract < ApplicationRecord
  belongs_to :admission

  validates :file_id,
                  presence: true
  validates :image_link,
                  presence: true
  validates :download_link,
                  presence: true
end

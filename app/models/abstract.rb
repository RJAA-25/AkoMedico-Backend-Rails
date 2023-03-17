class Abstract < ApplicationRecord
  belongs_to :admission

  validates :image_url,
                  presence: true
end

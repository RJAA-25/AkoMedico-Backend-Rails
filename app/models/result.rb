class Result < ApplicationRecord
  belongs_to :result_issue, polymorphic: true

  validates :image_url,
                  presence: true
end

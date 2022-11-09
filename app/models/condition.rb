class Condition < ApplicationRecord
  belongs_to :user

  validates :diganosis,
                  presence: true
  validates :start,
                  presence: true,
                  comparison: { less_than_or_equal_to: Date.current }

end

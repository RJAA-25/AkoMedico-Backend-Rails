class Condition < ApplicationRecord
  belongs_to :user

  validates :diagnosis,
                  presence: true
  validates :start,
                  presence: true,
                  comparison: { less_than_or_equal_to: Date.current }
  validates :end,
                  allow_nil: true,
                  comparison: { greater_than: :start, less_than_or_equal_to: Date.current }

end

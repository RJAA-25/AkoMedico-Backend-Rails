class Condition < ApplicationRecord
  belongs_to :user

  validates :diagnosis,
                  presence: true
  validates :start_date,
                  presence: true,
                  comparison: { less_than_or_equal_to: Date.today }
  validates :end_date,
                  allow_nil: true,
                  comparison: { greater_than: :start_date, less_than_or_equal_to: Date.today }

end

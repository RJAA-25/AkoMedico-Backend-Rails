class Category < ApplicationRecord
  belongs_to :user

  before_validation do
    self.name = name.capitalize if name
  end

  validates :name, 
                  presence: true
  validates :folder_id,
                  presence: true
end

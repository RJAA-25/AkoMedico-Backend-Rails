class Result < ApplicationRecord
  belongs_to :result_issue, polymorphic: true
end

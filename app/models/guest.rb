class Guest < ApplicationRecord
  validates :name, presence: true
  validates :guests_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # message is optional, so no validation needed
end

class City < ApplicationRecord
  belongs_to :country

  scope :active, -> { where(active: true) }
end

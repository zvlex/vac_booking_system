class Country < ApplicationRecord
  scope :active, -> { where(active: true) }
end

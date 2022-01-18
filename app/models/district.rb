class District < ApplicationRecord
  belongs_to :city
  scope :active, -> { where(active: true) }
end

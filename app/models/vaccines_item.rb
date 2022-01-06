class VaccinesItem < ApplicationRecord
  scope :active, -> { where(active: true) }
end

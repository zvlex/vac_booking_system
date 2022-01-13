class BusinessUnitSlot < ApplicationRecord
  belongs_to :business_unit
  belongs_to :user

  validates :duration, :start_date, :end_date, :business_unit_id, :user_id, presence: true
  validates :duration, inclusion: { in: %w[5 10 12 15 20 30] }

  scope :active, -> { where(active: true) }
end

class Booking < ApplicationRecord
  include AASM

  aasm :column => 'step_state', whiny_persistence: true do
    state :pending, initial: true
    state :patient_upserted, :reserved, :finished

    event :upsert_patient do
      transitions from: :pending, to: :patient_upserted
    end

    event :mark_as_pending do
      transitions from: :patient_upserted, to: :pending
    end

    event :reserve do
      transitions from: :patient_upserted, to: :reserved
    end

    event :cancel_reserve do
      transitions from: :reserved, to: :patient_upserted
    end

    event :finish do
      transitions from: :reserved, to: :finished
    end
  end

  belongs_to :vaccine, class_name: 'VaccinesItem', foreign_key: :vaccine_id
  belongs_to :patient, optional: true
  belongs_to :order, optional: true
end

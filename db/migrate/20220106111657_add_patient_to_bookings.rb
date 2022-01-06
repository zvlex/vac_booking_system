class AddPatientToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :patient, foreign_key: true
  end
end

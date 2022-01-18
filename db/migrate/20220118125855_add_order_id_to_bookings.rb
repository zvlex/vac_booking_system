class AddOrderIdToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :order, foreign_key: true
  end
end

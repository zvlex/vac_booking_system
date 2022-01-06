class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";')

    create_table :bookings do |t|
      t.uuid :guid, null: false, default: 'uuid_generate_v4()'
      t.bigint :vaccine_id, foreign_key: { to_table: :vaccines_items }, null: false
      t.string :step_state, limit: 50, index: true

      t.timestamps
    end

    add_index :bookings, :guid, unique: true
  end
end

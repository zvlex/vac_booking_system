class CreateBusinessUnitSlots < ActiveRecord::Migration[6.1]
  def change
    execute('CREATE EXTENSION IF NOT EXISTS "btree_gist";')

    create_table :business_unit_slots do |t|
      t.references :business_unit, null: false, foreign_key: true
      t.integer :duration, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :active, null: false, default: false

      t.timestamps
    end

    execute('
      ALTER TABLE business_unit_slots ADD CONSTRAINT bu_slots_no_intersection_date_ranges
      EXCLUDE USING gist (business_unit_id WITH =, tsrange(start_date, end_date) WITH &&)
    ')
  end
end

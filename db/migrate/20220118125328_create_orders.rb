class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :business_unit_slot, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.string :order_code, limit: 16, null: false
      t.datetime :order_date, null: false
      t.boolean :finished, null: false, default: false

      t.timestamps
    end

    add_index :orders, :order_code, unique: true
    add_index :orders, [:business_unit_slot_id, :order_date], unique: true
  end
end

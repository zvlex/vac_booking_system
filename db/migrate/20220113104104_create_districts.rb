class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.references :city, null: false, foreign_key: true
      t.string :name, limit: 150, null: false
      t.string :code, limit: 50, null: false
      t.boolean :active, null: false, default: false
    end

    add_index :districts, [:city_id, :code], unique: true
  end
end

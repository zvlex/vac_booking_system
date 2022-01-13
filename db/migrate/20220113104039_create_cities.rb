class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name, limit: 150, null: false
      t.string :code, limit: 50, null: false
      t.boolean :active, null: false, default: false
    end

    add_index :cities, [:country_id, :code], unique: true
  end
end

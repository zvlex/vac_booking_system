class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, limit: 150, null: false
      t.string :code, limit: 50, null: false
      t.boolean :active, null: false, default: false
    end

    add_index :countries, :code, unique: true
  end
end

class CreateVaccinesItems < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccines_items do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: false
    end

    add_index :vaccines_items, :name, unique: true
  end
end

class CreateOrderSmsMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :order_sms_messages do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :code, limit: 16, null: false, index: true
      t.string :title, null: false
      t.string :message, null: false
      t.datetime :sent_at

      t.timestamps
    end
  end
end

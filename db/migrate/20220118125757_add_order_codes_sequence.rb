class AddOrderCodesSequence < ActiveRecord::Migration[6.1]
  def change
    execute('CREATE SEQUENCE order_code START 1001;')
  end
end

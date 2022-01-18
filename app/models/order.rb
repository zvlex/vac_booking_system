class Order < ApplicationRecord
  belongs_to :business_unit_slot
  belongs_to :patient

  before_create do
    self.order_code = order_next_code
  end

  def order_next_code
    ActiveRecord::Base.connection.select_one("SELECT nextval('order_code');")['nextval']
  end
end

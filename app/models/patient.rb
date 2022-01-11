class Patient < ApplicationRecord
  validates :first_name, :last_name, :pin, :birth_date, :mobile_phone, presence: true

  validates :pin, length: {is: 11}, unless: Proc.new { |rec| rec.non_resident? }
end

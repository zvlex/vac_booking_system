class BusinessUnit < ApplicationRecord
  belongs_to :country
  belongs_to :city
  belongs_to :district
end

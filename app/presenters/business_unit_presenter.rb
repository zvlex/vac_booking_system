class BusinessUnitPresenter < Struct.new(:business_unit)
  def id
    business_unit&.id
  end

  def country_id
    business_unit&.country_id
  end

  def city_id
    business_unit&.city_id
  end

  def district_id
    business_unit&.district_id
  end
end

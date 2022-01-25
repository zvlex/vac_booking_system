class BookingPresenter < Struct.new(:booking)
  def patient_full_name
    "#{patient.first_name} #{patient.last_name}"
  end

  def patient_pin
    patient.pin
  end

  def patient_email
    patient.email
  end

  def patient_birth_date
    patient.birth_date&.strftime('%F')
  end

  def patient_mobile_phone
    patient.mobile_phone
  end

  def order_country_name
    bu_unit.country.name
  end

  def order_city_name
    bu_unit.city.name
  end

  def order_district_name
    bu_unit.district.name
  end

  def order_business_unit_address
    "#{order_country_name}, #{order_city_name}, #{order_district_name} - #{bu_unit.name}"
  end

  def order_date
    booking.order.order_date&.strftime('%F %H:%M')
  end

  private

  def patient
    @patient ||= booking.patient
  end

  def order_slot
    booking.order.business_unit_slot
  end

  def bu_unit
    @bu_unit ||= order_slot.business_unit
  end
end

module Web
  class Step0Service
    attr_accessor :current_vaccine, :record, :booking

    def initialize(vaccine)
      @vaccine = vaccine
    end

    def call(current_booking)
      @record = current_booking&.patient || Patient.new
      @current_vaccine = current_booking&.vaccine || @vaccine

      @booking = current_booking || Booking.create(guid: SecureRandom.uuid, vaccine_id: @current_vaccine.id)
    end
  end
end

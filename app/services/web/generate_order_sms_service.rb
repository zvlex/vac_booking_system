module Web
  class GenerateOrderSmsService
    attr_reader :booking

    def initialize(booking)
      @booking = booking
    end

    def call
      OrderSmsMessage.create!(booking_id: booking.id, code: order_code, title: title, message: message)
    end

    private

    def order_code
      booking.order.order_code
    end

    def title
      'VacBookingSystem'
    end

    def message
      "Your order code: #{order_code}"
    end
  end
end

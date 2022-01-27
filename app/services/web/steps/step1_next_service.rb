module Web
  module Steps
    class Step1NextService
      include Interactor

      before do
        context.current_step = 1
        context.next_step = 2
        context.last_step = false
      end

      def call
        context.record = context.booking.order || Order.new

        ActiveRecord::Base.transaction do
          context.record.patient_id = context.booking.patient_id
          context.record.update!(context.params)
          context.record.save!

          update_booking!
        end
      rescue => e
        catch_errors(e)
      end

      private

      def catch_errors(e)
        context.next_step = 1
        context.record.errors.add(:base, e)
        context.fail!(message: e)
      end

      def db_patient_attrs
        context.params.slice(:first_name, :last_name, :birth_date, :pin, :non_resident)
      end

      def update_booking!
        context.booking.reserve!
        context.booking.order_id = context.record.id
        context.booking.save!
      end
    end
  end
end

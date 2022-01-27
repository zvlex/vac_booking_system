module Web
  module Steps
    class Step0NextService
      include Interactor

      before do
        context.current_step = 0
        context.next_step = 1
        context.last_step = false
      end

      def call
        context.record = context.booking.patient || Patient.new

        ActiveRecord::Base.transaction do
          context.record.update!(context.params)
          context.record.save!
          update_booking!
        end
      rescue ActiveRecord::RecordNotUnique
        context.record = Patient.find_by(db_patient_attrs)

        if context.record.blank?
          context.fail!(message: I18n.t('web.main.unknown_error'))
        else
          update_patient_booking!
        end
      rescue => e
        catch_errors(e)
      end

      private

      def update_patient_booking!
        update_booking!
      rescue => e
        catch_errors(e)
      end

      def catch_errors(e)
        context.next_step = 0
        context.record.errors.add(:base, e)
        context.fail!(message: e)
      end

      def db_patient_attrs
        context.params.slice(:first_name, :last_name, :birth_date, :pin, :non_resident)
      end

      def update_booking!
        context.booking.upsert_patient!
        context.booking.patient_id = context.record.id
        context.booking.save!
      end
    end
  end
end

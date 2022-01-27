module Web
  module Steps
    class Step1PrevService
      include Interactor

      before do
        context.current_step = 1
      end

      def call
        context.record = context.booking.patient

        context.booking.mark_as_pending!
      rescue => e
        catch_errors(e)
      end

      private

      def catch_errors(e)
        context.prev_step = 0
        context.record.errors.add(:base, e)
        context.fail!(message: e)
      end
    end
  end
end

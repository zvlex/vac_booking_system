module Web
  module Steps
    class Step2PrevService
      include Interactor

      before do
        context.current_step = 2
      end

      def call
        context.record = context.booking.order

        context.booking.cancel_reserve!
      rescue => e
        catch_errors(e)
      end

      private

      def catch_errors(e)
        context.prev_step = 1
        context.record.errors.add(:base, e)
        context.fail!(message: e)
      end
    end
  end
end

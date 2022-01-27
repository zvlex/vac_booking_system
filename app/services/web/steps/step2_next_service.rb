module Web
  module Steps
    class Step2NextService
      include Interactor

      before do
        context.current_step = 2
        context.next_step = nil
        context.last_step = true
      end

      def call
        context.record = context.booking

        ActiveRecord::Base.transaction do
          context.record.order.update!(finished: true)
          context.record.finish!
          context.sms = Web::GenerateOrderSmsService.new(context.record).call
        end

        SendOrderSmsWorker.perform_async(context.sms.id)
      rescue ActiveRecord::RecordNotUnique
        catch_errors(I18n.t('web.main.step2.slot_already_reserved'))
      rescue => e
        catch_errors(e)
      ensure
        context.record = BookingPresenter.new(context.record)
      end

      private

      def catch_errors(e)
        context.next_step = 2
        context.record.errors.add(:base, e)
        context.fail!(message: e)
      end
    end
  end
end

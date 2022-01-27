module Web
  class StepsWrapper
    include Interactor

    def call
      step_name = context.booking&.step_state || 'pending'

      send("setup_#{step_name}_step")
    end

    private

    def setup_pending_step
      context.next_service = Steps::Step0NextService
      context.prev_service = Steps::Step0PrevService
      context.record = context.booking&.patient || Patient.new
      context.step_number = 0
    end

    def setup_patient_upserted_step
      context.next_service = Steps::Step1NextService
      context.prev_service = Steps::Step1PrevService
      context.record = context.booking&.order || Order.new
      context.step_number = 1
    end

    def setup_reserved_step
      context.next_service = Steps::Step2NextService
      context.prev_service = Steps::Step2PrevService
      context.record = BookingPresenter.new(context.booking)
      context.step_number = 2
    end
  end
end

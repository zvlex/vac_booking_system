module Web
  class PrevStepService
    include Interactor

    def call
      booking = context.booking

      step_wrapper = Web::StepsWrapper.call(booking: booking)
      result = step_wrapper.prev_service.call(booking: booking, params: {})

      normalize_result(result)
    end

    private

    def normalize_result(result)
      context.record = result.record
      context.current_step = result.current_step

      context.fail!(message: result.message) if result.failure?
    end
  end
end

module Web
  class NextStepService
    include Interactor

    def call
      booking = context.booking

      step_wrapper = Web::StepsWrapper.call(booking: booking)
      result = step_wrapper.next_service.call(booking: booking, params: send("step#{step_wrapper.step_number}_params"))

      normalize_result(result)
    end

    private

    def normalize_result(result)
      context.record = result.record
      context.next_step = result.next_step
      context.current_step = result.current_step

      context.send('last_step?=', result.last_step)

      context.fail!(message: result.message) if result.failure?
    end

    def step0_params
      context.params.require(:patient).permit(
        :first_name,
        :last_name,
        :pin,
        :birth_date,
        :non_resident,
        :mobile_phone,
        :email
      )
    end

    def step1_params
      context.params.require(:order).permit(:order_date, :business_unit_slot_id)
    end

    def step2_params
      {}
    end
  end
end

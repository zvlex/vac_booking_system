module Web
  class NextStepService
    include Interactor

    def call
      booking = context.booking
      params = context.params

      result =
        case
        when booking.pending?
          Steps::Step0Service.call(booking: booking, params: step0_params)
        when booking.patient_upserted?
          Steps::Step1Service.call(booking: booking, params: step1_params)
        when booking.reserved?
          Steps::Step2Service.call(booking: booking, params: step2_params)
        else
          # TODO: some code here
        end

      normalize_result(result)
    end

    private

    def normalize_result(result)
      context.record = result.record
      context.next_step = result.next_step
      context.current_step = result.current_step

      context.send('last_step?=', false) # TODO:

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
  end
end

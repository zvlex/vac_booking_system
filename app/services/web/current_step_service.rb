module Web
  class CurrentStepService
    include Interactor

    STEP0 = 0
    STEP1 = 1
    STEP2 = 2

    before :check_vaccine

    def call
      prepare_current_step

      create_booking! if context.booking.blank?

      fetch_current_step
    end

    private

    def create_booking!
      context.booking = Booking.create!(guid: SecureRandom.uuid, vaccine_id: context.current_vaccine.id)
    rescue => e
      context.fail!(message: e)
    end

    def check_vaccine
      context.selected_vaccine = fetch_current_vaccine

      if context.selected_vaccine.blank?
        context.fail!(message: I18n.t('web.main.no_vaccine'))
      else
        context.booking = nil if context.booking&.vaccine && context.selected_vaccine.name != context.booking.vaccine.name
      end
    end

    def prepare_current_step
      # TODO: refactor on step2
      context.record = context.booking&.patient || Patient.new

      context.current_vaccine = context.booking&.vaccine || context.selected_vaccine
    end

    def fetch_current_vaccine
      name = context.params[:vaccine]&.downcase

      return nil unless name

      VaccinesItem.active.where('lower(name) = ?', name).take
    end

    def fetch_current_step
      case
      when context.booking.pending?
        context.render_step = STEP0
      when context.booking.patient_upserted?
        context.render_step = STEP1
      when context.booking.reserved?
        context.render_step = STEP2
      else
        context.render_step = STEP0
      end
    end
  end
end

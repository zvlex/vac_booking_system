module Admin
  class BusinessUnitSlotsController < ApplicationController
    before_action :init_service

    def index
      @pagy, @slots = pagy(@slot_service.list)
    end

    def new
      result = @slot_service.new

      @slot = result.slot
    end

    def edit
      result = @slot_service.edit(params[:id])

      @slot = result.slot
    end

    def create
      result = @slot_service.create(slot_params)

      @slot = result.slot

      if result.success?
        redirect_to admin_business_unit_slots_path, notice: I18n.t('admin.slots.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @slot_service.update(params[:id], slot_params)

      @slot = result.slot

      if result.success?
        redirect_to admin_business_unit_slots_path, notice: I18n.t('admin.slots.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @slot_service.delete(params[:id])

      if result.success?
        redirect_to admin_business_unit_slots_path, notice: I18n.t('admin.slots.notices.deleted')
      end
    end

    private

    def init_service
      @slot_service = Slots::SlotService.new(current_user)
    end

    def slot_params
      params
        .require(:business_unit_slot)
        .permit(:id, :duration, :business_unit_id, :start_date, :end_date, :user_id, :active)
    end
  end
end

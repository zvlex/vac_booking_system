module Slots
  class SlotService
    attr_reader :current_user, :result

    def initialize(current_user)
      @current_user = current_user
      @result = OpenStruct.new(success?: false, slot: BusinessUnitSlot.new)
    end

    def list
      BusinessUnitSlot.active.order(created_at: :desc)
    end

    def new
      result
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      params[:user_id] = current_user.id

      result.tap do |r|
        r.slot = BusinessUnitSlot.new(params)
        r.send("success?=", r.slot.save)
      end
    rescue ActiveRecord::StatementInvalid
      result.tap do |r|
        r.slot.errors.add(:base, I18n.t('admin.slots.errors.duplicate_slot_error'))
      end
    end

    def update(id, params)
      params[:user_id] = current_user.id

      find_record(id)

      result.tap do |r|
        r.send("success?=", r.slot.update(params))
      end
    rescue ActiveRecord::StatementInvalid
      result.tap do |r|
        r.slot.errors.add(:base, I18n.t('admin.slots.errors.duplicate_slot_error'))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.slot.destroy)
      end
    end

    private

    def find_record(id)
      result.slot = BusinessUnitSlot.find(id)
      result
    end
  end
end

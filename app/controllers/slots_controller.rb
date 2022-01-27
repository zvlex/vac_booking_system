class SlotsController < ApplicationController
  before_action do
    @dt = params[:dt]
  end

  def index
    @bu_unit = BusinessUnit.find(params[:business_unit_id])

    slots =
      BusinessUnitSlot
      .select('bus.id, bus.duration, bus.start_date::date AS current_start_date, slots.item AS slot_item')
      .from(@bu_unit.business_unit_slots.active, 'bus')
      .joins(
        "LEFT JOIN LATERAL (
          SELECT generate_series(bus.start_date, bus.end_date, bus.duration * '1 minutes'::interval)::timestamp AS item
        ) slots ON true"
      )
      .joins(
        'LEFT JOIN orders o ON o.business_unit_slot_id = bus.id
        AND o.finished = true AND o.order_date::timestamp = slots.item'
      )
      .where('o.id IS NULL')
      .where('slots.item >= ?', Time.current)
      .order(:start_date)

    @bu_slots = slots.group_by { |r| [r.current_start_date, r.duration] }
  end

  def fetch_cities
    @cities = City.active.where(country_id: params[:country_id])

    render partial: 'cities', object: @cities, locals: { dt: @dt }, layout: false
  end

  def fetch_districts
    @districts = District.active.where(city_id: params[:city_id])

    render partial: 'districts', object: @districts, locals: { dt: @dt }, layout: false
  end

  def fetch_business_units
    @bu_units = BusinessUnit.active.where(
      country_id: params[:country_id],
      city_id: params[:city_id],
      district_id: params[:district_id]
    )

    render partial: 'bu_units', object: @bu_units, locals: { dt: @dt }, layout: false
  end
end

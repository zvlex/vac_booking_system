import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = [
	"country",
	"city",
	"district",
	"bu_unit",
	"slots"
    ]

    static values = {
	countryId: String,
	cityId: String,
	districtId: String,
	buUnitId: String,
	orderDate: String
    }

    connect() {
	if(this.buUnitIdValue) {
	    this.fetchCities()
	    this.fetchDistricts()
	    this.fetchBusinessUnits()
	    this.fetchSlots()
	}
    }

    fetchCities() {
	let country_id = this.countryTarget.value || this.countryIdValue

	Rails.ajax({
	    type: "GET",
	    url: "/slots/fetch_cities",
	    data: "country_id=" + country_id + "&dt=" + this.cityIdValue,
	    success: (data) => {
		this.cityTarget.innerHTML = data.body.innerHTML
	    }
	});
    }


    fetchDistricts() {
	let city_id = this.cityTarget.value || this.cityIdValue

	Rails.ajax({
	    type: "GET",
	    url: "/slots/fetch_districts",
	    data: "city_id=" + city_id + "&dt=" + this.districtIdValue,
	    success: (data) => {
		this.districtTarget.innerHTML = data.body.innerHTML
	    }
	});
    }


    fetchBusinessUnits() {
	let country_id = this.countryTarget.value || this.countryIdValue
	let city_id = this.cityTarget.value || this.cityIdValue
	let district_id = this.districtTarget.value || this.districtIdValue

	Rails.ajax({
	    type: "GET",
	    url: "/slots/fetch_business_units",
	    data: "country_id=" + country_id + "&city_id=" + city_id + "&district_id=" + district_id + "&dt=" + this.buUnitIdValue,
	    success: (data) => {
		this.bu_unitTarget.innerHTML = data.body.innerHTML
	    }
	});
    }


    fetchSlots() {
	let bu_id = this.bu_unitTarget.value || this.buUnitIdValue

	Rails.ajax({
	    type: "GET",
	    url: "/slots/",
	    data: "business_unit_id=" + bu_id + "&dt=" + this.orderDateValue,
	    success: (data) => {
		this.slotsTarget.innerHTML = data.body.innerHTML

		let currentSlot = document.querySelector('.slot-item-selected')

		if(currentSlot) {
		    currentSlot.classList.toggle("btn-warning")

		    if(currentSlot.classList.contains('btn-warning')) {
			document.querySelector('input.step1_submit').classList.remove('invisible')
		    }
		}
	    }
	});
    }

    selectSlot() {
	Array.from(document.querySelectorAll('.slot-item')).forEach(function(el) {
	    if(el !== event.target) {
		el.classList.remove('btn-warning')
		document.querySelector('input.step1_submit').classList.add('invisible')
	    }
	})
	event.target.classList.toggle("btn-warning")
	document.querySelector('input#order_order_date').value = event.params['slotTime']
	document.querySelector('input#order_business_unit_slot_id').value = event.params['slotId']

	if(event.target.classList.contains('btn-warning')) {
	    document.querySelector('input.step1_submit').classList.remove('invisible')
	}
    }
}

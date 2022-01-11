# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_11_124256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "bookings", force: :cascade do |t|
    t.uuid "guid", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "vaccine_id", null: false
    t.string "step_state", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "patient_id"
    t.index ["guid"], name: "index_bookings_on_guid", unique: true
    t.index ["patient_id"], name: "index_bookings_on_patient_id"
    t.index ["step_state"], name: "index_bookings_on_step_state"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 50, null: false
    t.date "birth_date", null: false
    t.string "pin", limit: 50, null: false
    t.boolean "non_resident", default: false, null: false
    t.string "mobile_phone", limit: 30, null: false
    t.string "email", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name", "last_name", "pin", "birth_date"], name: "unique_patient_index", unique: true, where: "(non_resident = false)"
    t.index ["mobile_phone"], name: "index_patients_on_mobile_phone"
    t.index ["pin"], name: "index_patients_on_pin"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", limit: 50, null: false
    t.boolean "active", default: false, null: false
    t.boolean "super_admin", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccines_items", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.index ["name"], name: "index_vaccines_items_on_name", unique: true
  end

  add_foreign_key "bookings", "patients"
end

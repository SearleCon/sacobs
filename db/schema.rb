# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140113065440) do

  create_table "addresses", force: true do |t|
    t.string   "street_address1"
    t.string   "street_address2"
    t.string   "city"
    t.string   "postal_code"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type"

  create_table "bookings", force: true do |t|
    t.integer  "trip_id"
    t.decimal  "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",     default: 0
    t.datetime "expiry_date"
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "reference_no"
    t.integer  "main_id"
    t.boolean  "has_return",   default: false
  end

  add_index "bookings", ["client_id"], name: "index_bookings_on_client_id"
  add_index "bookings", ["main_id"], name: "index_bookings_on_main_id"
  add_index "bookings", ["trip_id"], name: "index_bookings_on_trip_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "bookings_stops", force: true do |t|
    t.integer "booking_id"
    t.integer "stop_id"
  end

  add_index "bookings_stops", ["booking_id", "stop_id"], name: "index_bookings_stops_on_booking_id_and_stop_id"
  add_index "bookings_stops", ["stop_id", "booking_id"], name: "index_bookings_stops_on_stop_id_and_booking_id"

  create_table "buses", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.string   "year"
    t.string   "model"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "buses", ["user_id"], name: "index_buses_on_user_id"

  create_table "cities", force: true do |t|
    t.string  "name"
    t.string  "slug"
    t.integer "user_id"
    t.integer "venues_count", default: 0
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true
  add_index "cities", ["user_id"], name: "index_cities_on_user_id"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tel_no"
    t.string   "cell_no"
    t.string   "email"
    t.string   "slug"
    t.integer  "user_id"
  end

  add_index "clients", ["slug"], name: "index_clients_on_slug", unique: true
  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "connections", force: true do |t|
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.decimal  "percentage", precision: 2, scale: 5
    t.decimal  "cost",       precision: 8, scale: 2
    t.string   "name"
    t.integer  "from_id"
    t.integer  "to_id"
  end

  add_index "connections", ["from_id"], name: "index_connections_on_from_id"
  add_index "connections", ["route_id"], name: "index_connections_on_route_id"
  add_index "connections", ["to_id"], name: "index_connections_on_to_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "destinations", force: true do |t|
    t.integer  "route_id"
    t.integer  "city_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinations", ["city_id", "route_id"], name: "index_destinations_on_city_id_and_route_id"
  add_index "destinations", ["city_id"], name: "index_destinations_on_city_id"
  add_index "destinations", ["route_id"], name: "index_destinations_on_route_id"

  create_table "discounts", force: true do |t|
    t.decimal  "percentage",        precision: 2, scale: 5
    t.integer  "passenger_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "discounts", ["passenger_type_id"], name: "index_discounts_on_passenger_type_id"
  add_index "discounts", ["user_id"], name: "index_discounts_on_user_id"

  create_table "drivers", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "user_id"
  end

  add_index "drivers", ["slug"], name: "index_drivers_on_slug", unique: true
  add_index "drivers", ["user_id"], name: "index_drivers_on_user_id"

  create_table "drivers_trips", force: true do |t|
    t.integer "driver_id"
    t.integer "trip_id"
  end

  add_index "drivers_trips", ["driver_id", "trip_id"], name: "index_drivers_trips_on_driver_id_and_trip_id"
  add_index "drivers_trips", ["trip_id", "driver_id"], name: "index_drivers_trips_on_trip_id_and_driver_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "invoices", force: true do |t|
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "billing_date"
  end

  add_index "invoices", ["booking_id"], name: "index_invoices_on_booking_id"

  create_table "line_items", force: true do |t|
    t.string   "description"
    t.integer  "discount_percentage"
    t.decimal  "discount_amount",     precision: 8, scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "gross_price",         precision: 8, scale: 2
    t.decimal  "nett_price",          precision: 8, scale: 2
  end

  add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id"

  create_table "passenger_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "passenger_type_id"
    t.string   "cell_no"
    t.string   "email"
  end

  add_index "passengers", ["booking_id"], name: "index_passengers_on_booking_id"
  add_index "passengers", ["passenger_type_id"], name: "index_passengers_on_passenger_type_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "routes", force: true do |t|
    t.decimal  "cost",              precision: 8, scale: 2
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "connections_count",                         default: 0
  end

  add_index "routes", ["slug"], name: "index_routes_on_slug", unique: true
  add_index "routes", ["user_id"], name: "index_routes_on_user_id"

  create_table "scriptures", force: true do |t|
    t.string   "verse"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seats", force: true do |t|
    t.string   "row"
    t.integer  "number"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seats", ["bus_id"], name: "index_seats_on_bus_id"

  create_table "settings", force: true do |t|
    t.integer  "booking_expiry_period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stops", force: true do |t|
    t.integer  "connection_id"
    t.integer  "trip_id"
    t.datetime "arrive"
    t.datetime "depart"
    t.integer  "available_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stops", ["connection_id"], name: "index_stops_on_connection_id"
  add_index "stops", ["trip_id"], name: "index_stops_on_trip_id"

  create_table "trips", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "route_id"
    t.integer  "bus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "trips", ["bus_id"], name: "index_trips_on_bus_id"
  add_index "trips", ["route_id"], name: "index_trips_on_route_id"
  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "surname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "venues", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["city_id"], name: "index_venues_on_city_id"

  create_table "vouchers", force: true do |t|
    t.string   "ref_no"
    t.decimal  "amount"
    t.boolean  "active",     default: true
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "vouchers", ["client_id"], name: "index_vouchers_on_client_id"
  add_index "vouchers", ["user_id"], name: "index_vouchers_on_user_id"

end

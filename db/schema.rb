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

ActiveRecord::Schema.define(version: 20151104202814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "attendees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "attended"
    t.string   "discount_code"
    t.integer  "locked_by"
    t.datetime "locked_until",     default: '2016-02-15 18:33:50'
    t.integer  "order_id"
    t.integer  "public_event_id"
    t.integer  "private_event_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "attendees", ["public_event_id"], name: "index_attendees_on_public_event_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "public_event_id"
    t.integer  "private_event_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "status",           default: "Processed"
    t.string   "email"
    t.string   "phone"
    t.string   "type"
    t.integer  "total"
    t.integer  "quantity"
    t.string   "payment_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "discount_code"
    t.string   "groupon_code"
  end

  add_index "orders", ["public_event_id"], name: "index_orders_on_public_event_id", using: :btree

  create_table "private_events", force: :cascade do |t|
    t.string   "status",            default: "Pending"
    t.integer  "available_slots"
    t.integer  "purchased_slots"
    t.string   "name"
    t.string   "event_type"
    t.text     "description"
    t.integer  "price"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "live"
    t.string   "occasion"
    t.string   "phone"
    t.string   "email"
    t.string   "how_hear"
    t.string   "employee_referral"
    t.text     "special_request"
    t.integer  "artist_id"
    t.integer  "experience_id"
    t.integer  "location_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "private_events", ["artist_id"], name: "index_private_events_on_artist_id", using: :btree
  add_index "private_events", ["experience_id"], name: "index_private_events_on_experience_id", using: :btree
  add_index "private_events", ["location_id"], name: "index_private_events_on_location_id", using: :btree

  create_table "promos", force: :cascade do |t|
    t.string   "email"
    t.string   "code"
    t.integer  "discount_percentage"
    t.integer  "number_of_uses",       default: 1
    t.integer  "number_of_times_used", default: 0
    t.date     "expiration_date",      default: '2017-02-15'
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "promos", ["code", "email"], name: "index_promos_on_code_and_email", unique: true, using: :btree

  create_table "public_events", force: :cascade do |t|
    t.string   "status"
    t.integer  "available_slots"
    t.integer  "purchased_slots"
    t.integer  "byob_fee"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "live"
    t.integer  "artist_id"
    t.integer  "experience_id"
    t.integer  "location_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "discount_code"
    t.integer  "unlimited_wine",      default: 0
    t.integer  "unlimited_mimosas",   default: 0
    t.integer  "voucher_upgrade_fee", default: 0
    t.boolean  "groupon"
  end

  add_index "public_events", ["artist_id"], name: "index_public_events_on_artist_id", using: :btree
  add_index "public_events", ["date"], name: "index_public_events_on_date", using: :btree
  add_index "public_events", ["experience_id"], name: "index_public_events_on_experience_id", using: :btree
  add_index "public_events", ["location_id"], name: "index_public_events_on_location_id", using: :btree
  add_index "public_events", ["name"], name: "index_public_events_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                                null: false
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

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

ActiveRecord::Schema.define(version: 20130805234349) do

  create_table "events", force: true do |t|
    t.integer  "lab_id"
    t.string   "name"
    t.text     "details"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["lab_id"], name: "index_events_on_lab_id"

  create_table "humans", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.integer  "ordinal"
    t.string   "details"
    t.integer  "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "humans", ["user_id", "lab_id"], name: "index_humans_on_user_id_and_lab_id"

  create_table "labs", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "address_notes"
    t.string   "state_code"
    t.string   "country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",         null: false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end

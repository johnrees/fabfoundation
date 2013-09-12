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

ActiveRecord::Schema.define(version: 20130912143847) do

  create_table "applications", force: true do |t|
    t.integer  "lab_id"
    t.integer  "creator_id"
    t.text     "state"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["creator_id"], name: "index_applications_on_creator_id"
  add_index "applications", ["lab_id"], name: "index_applications_on_lab_id"

  create_table "claims", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.string   "state"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claims", ["lab_id"], name: "index_claims_on_lab_id"
  add_index "claims", ["user_id"], name: "index_claims_on_user_id"

  create_table "comments", force: true do |t|
    t.string   "ancestry"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "events", force: true do |t|
    t.integer  "lab_id"
    t.integer  "creator_id"
    t.string   "name"
    t.text     "details"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day",    default: false, null: false
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id"
  add_index "events", ["lab_id"], name: "index_events_on_lab_id"

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "ordinal"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities_labs", id: false, force: true do |t|
    t.integer "facility_id"
    t.integer "lab_id"
  end

  add_index "facilities_labs", ["facility_id", "lab_id"], name: "index_facilities_labs_on_facility_id_and_lab_id"

  create_table "humans", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.integer  "ordinal"
    t.string   "full_name"
    t.string   "details"
    t.string   "phone"
    t.string   "email"
    t.integer  "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "humans", ["user_id", "lab_id"], name: "index_humans_on_user_id_and_lab_id"

  create_table "lab_applications", force: true do |t|
    t.integer  "lab_id"
    t.integer  "creator_id"
    t.string   "state"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lab_applications", ["creator_id"], name: "index_lab_applications_on_creator_id"
  add_index "lab_applications", ["lab_id"], name: "index_lab_applications_on_lab_id"

  create_table "labs", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "state"
    t.string   "ancestry"
    t.text     "description"
    t.string   "phone"
    t.integer  "facilities"
    t.string   "email"
    t.integer  "kind"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "street_address_3"
    t.string   "city"
    t.string   "postal_code"
    t.string   "country_code"
    t.string   "region"
    t.string   "subregion"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "opening_hours_bitmask"
    t.string   "time_zone"
    t.text     "address_notes"
    t.text     "opening_hours_notes"
    t.text     "application_notes"
    t.string   "avatar"
    t.text     "urls"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labs", ["creator_id"], name: "index_labs_on_creator_id"

  create_table "labs_users", id: false, force: true do |t|
    t.integer "lab_id"
    t.integer "user_id"
  end

  add_index "labs_users", ["lab_id", "user_id"], name: "index_labs_users_on_lab_id_and_user_id"

  create_table "referees", force: true do |t|
    t.integer  "lab_application_id"
    t.integer  "lab_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referees", ["lab_application_id"], name: "index_referees_on_lab_application_id"
  add_index "referees", ["lab_id"], name: "index_referees_on_lab_id"

  create_table "tool_types", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tools", force: true do |t|
    t.integer  "lab_id"
    t.integer  "tool_type_id"
    t.integer  "ordinal"
    t.string   "name"
    t.string   "description"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tools", ["lab_id"], name: "index_tools_on_lab_id"
  add_index "tools", ["tool_type_id"], name: "index_tools_on_tool_type_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "state"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "public_email"
    t.string   "public_phone"
    t.string   "city"
    t.string   "country_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "url"
    t.string   "twitter_username"
    t.date     "dob"
    t.text     "bio"
    t.string   "avatar"
    t.string   "locale"
    t.string   "time_zone"
    t.string   "invite_token"
    t.string   "forgot_password_token"
    t.boolean  "admin",                 default: false, null: false
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

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

ActiveRecord::Schema.define(version: 20140526203324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps_users", force: true do |t|
    t.integer "app_id"
    t.integer "user_id"
  end

  create_table "at_strings", force: true do |t|
    t.string   "title"
    t.string   "value"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "couleurs", force: true do |t|
    t.string   "title"
    t.string   "coul_type"
    t.string   "value_coul"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localizables", force: true do |t|
    t.string   "key_loc"
    t.string   "value"
    t.string   "lang"
    t.integer  "app_id"
    t.boolean  "missing",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "numbers", force: true do |t|
    t.string   "title"
    t.string   "value"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

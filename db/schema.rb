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

ActiveRecord::Schema.define(version: 2018_07_13_060210) do

  create_table "account_shortcuts", force: :cascade do |t|
    t.integer "shortcut_id"
    t.string "account_uid"
  end

  create_table "shortcuts", force: :cascade do |t|
    t.string "label"
    t.string "url"
    t.string "shortcut_type"
    t.string "engine_name"
    t.boolean "all_accounts"
  end

end

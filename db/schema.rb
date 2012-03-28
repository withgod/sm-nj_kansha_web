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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "fizz", :id => false, :force => true do |t|
    t.string "buzz"
  end

  create_table "nj_classes", :force => true do |t|
    t.integer  "classid",    :null => false
    t.string   "classname",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nj_kansha_results", :force => true do |t|
    t.integer  "jump_count",    :null => false
    t.integer  "nj_steamid_id", :null => false
    t.integer  "nj_map_id",     :null => false
    t.integer  "nj_class_id",   :null => false
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nj_kansha_results", ["nj_class_id"], :name => "nj_class_id"
  add_index "nj_kansha_results", ["nj_map_id"], :name => "nj_map_id"
  add_index "nj_kansha_results", ["nj_steamid_id"], :name => "nj_steamid_id"

  create_table "nj_maps", :force => true do |t|
    t.string   "mapname",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nj_maps", ["mapname"], :name => "mapname", :unique => true

  create_table "nj_steam_nicknames", :force => true do |t|
    t.integer  "nj_steamid_id", :null => false
    t.string   "nickname",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nj_steam_nicknames", ["nj_steamid_id", "nickname"], :name => "uq_steamid_nickname", :unique => true

  create_table "nj_steamids", :force => true do |t|
    t.string   "steamid",                 :null => false
    t.integer  "steamcomid", :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nj_steamids", ["steamid", "steamcomid"], :name => "uq_steamid_steamcomid", :unique => true

end

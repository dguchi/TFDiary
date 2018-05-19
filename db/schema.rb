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

ActiveRecord::Schema.define(version: 20180517134925) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "diary_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diaries", force: :cascade do |t|
    t.date     "date"
    t.text     "explain"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diary_menus", force: :cascade do |t|
    t.integer  "diary_id"
    t.integer  "menu_id"
    t.integer  "set"
    t.integer  "num"
    t.integer  "rest_min",   default: 0
    t.integer  "rest_sec",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "explain"
    t.text     "target"
    t.string   "image"
    t.integer  "leader_id"
    t.integer  "manager_id1"
    t.integer  "manager_id2"
    t.integer  "subleader_id1"
    t.integer  "subleader_id2"
    t.integer  "subleader_id3"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "kind",       limit: 1, default: 0,     null: false
    t.text     "explain"
    t.integer  "author_id"
    t.boolean  "secret",               default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.integer  "main_group_id"
    t.string   "image"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end

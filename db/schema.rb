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

ActiveRecord::Schema.define(version: 20161201211809) do

  create_table "follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_id"], name: "fk_rails_8326125693", using: :btree
    t.index ["user_id", "target_id"], name: "index_follows_on_user_id_and_target_id", unique: true, using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 4294967295, null: false
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "fk_rails_5b5ddfd518", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",                      null: false
    t.string   "name",                          null: false
    t.string   "email",                         null: false
    t.text     "bio",        limit: 4294967295, null: false
    t.string   "password",                      null: false
    t.string   "photo"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "follows", "users", column: "target_id", on_delete: :cascade
  add_foreign_key "follows", "users", on_delete: :cascade
  add_foreign_key "posts", "users", on_delete: :cascade
end

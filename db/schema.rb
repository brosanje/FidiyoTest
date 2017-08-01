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

ActiveRecord::Schema.define(version: 20170730011806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "username", null: false
    t.string "name", null: false
    t.string "logo", null: false
    t.string "main_contact", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "status", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_clients_on_lower_email"
    t.index "lower((main_contact)::text) varchar_pattern_ops", name: "index_clients_on_lower_main_contact_varchar_pattern_ops"
    t.index "lower((name)::text) varchar_pattern_ops", name: "index_clients_on_lower_name_varchar_pattern_ops"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["username"], name: "index_clients_on_username", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "video_categories", force: :cascade do |t|
    t.string "type"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((description)::text) varchar_pattern_ops", name: "index_video_categories_on_lower_description_varchar_pattern_ops"
    t.index ["type"], name: "index_video_categories_on_type", unique: true
  end

  create_table "video_clouds", force: :cascade do |t|
    t.string "backing_store"
    t.string "description"
    t.string "access"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((description)::text) varchar_pattern_ops", name: "index_video_clouds_on_lower_description_varchar_pattern_ops"
  end

  create_table "video_distributions", force: :cascade do |t|
    t.datetime "distributed_at"
    t.string "link_url"
    t.boolean "require_login"
    t.boolean "expired"
    t.integer "view_count_limit"
    t.string "description"
    t.bigint "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((description)::text) varchar_pattern_ops", name: "index_video_distribution_description_pattern"
    t.index ["video_id"], name: "index_video_distributions_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "resource_path"
    t.boolean "isSelect"
    t.string "color"
    t.string "description"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "video_category_id"
    t.bigint "video_cloud_id"
    t.index "lower((description)::text) varchar_pattern_ops", name: "index_videos_on_lower_description_varchar_pattern_ops"
    t.index ["resource_path"], name: "index_videos_on_resource_path"
    t.index ["users_id"], name: "index_videos_on_users_id"
    t.index ["video_category_id"], name: "index_videos_on_video_category_id"
    t.index ["video_cloud_id"], name: "index_videos_on_video_cloud_id"
  end

  add_foreign_key "video_distributions", "videos"
  add_foreign_key "videos", "users", column: "users_id"
  add_foreign_key "videos", "video_categories"
  add_foreign_key "videos", "video_clouds"
end

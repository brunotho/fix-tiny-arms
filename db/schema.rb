# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_27_162702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beep_timestamps", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.string "video_id"
    t.json "timestamps"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_beep_timestamps_on_habit_id"
  end

  create_table "habit_completions", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.date "completed_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id", "completed_on"], name: "index_habit_completions_on_habit_id_and_completed_on", unique: true
    t.index ["habit_id"], name: "index_habit_completions_on_habit_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "youtube_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "days_of_week", default: [], array: true
    t.time "time_of_day", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "beep_timestamps", "habits"
  add_foreign_key "habit_completions", "habits"
  add_foreign_key "habits", "users"
end

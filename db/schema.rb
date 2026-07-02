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

ActiveRecord::Schema[7.1].define(version: 2026_06_30_000100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborators", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.text "rfc"
    t.text "fiscal_address"
    t.text "curp"
    t.text "nss"
    t.date "start_date", null: false
    t.string "contract_type", null: false
    t.string "department", null: false
    t.string "position", null: false
    t.decimal "daily_salary", precision: 12, scale: 2, null: false
    t.decimal "salary", precision: 12, scale: 2, null: false
    t.string "entity_key", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collaborators_on_user_id"
  end

  create_table "managed_users", force: :cascade do |t|
    t.bigint "owner_user_id", null: false
    t.bigint "created_by_id", null: false
    t.string "name", null: false
    t.text "rfc"
    t.string "address", null: false
    t.string "phone", null: false
    t.string "website", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_managed_users_on_created_by_id"
    t.index ["owner_user_id"], name: "index_managed_users_on_owner_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "rfc", null: false
    t.string "password_digest", null: false
    t.string "session_token"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["rfc"], name: "index_users_on_rfc", unique: true
    t.index ["session_token"], name: "index_users_on_session_token"
  end

  add_foreign_key "collaborators", "users"
  add_foreign_key "managed_users", "users", column: "created_by_id"
  add_foreign_key "managed_users", "users", column: "owner_user_id"
end

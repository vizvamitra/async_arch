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

ActiveRecord::Schema[7.0].define(version: 2023_08_17_213707) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "auth_identities", force: :cascade do |t|
    t.string "username", null: false
    t.string "provider", limit: 50, default: ""
    t.string "uid", limit: 500, default: ""
    t.string "doorkeeper_access_token"
    t.string "doorkeeper_refresh_token"
    t.datetime "doorkeeper_expires_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_auth_identities_on_provider_and_uid", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "identity_id"
    t.string "public_id", null: false
    t.string "email", null: false
    t.integer "role", limit: 2, null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["identity_id"], name: "index_employees_on_identity_id"
    t.index ["public_id"], name: "index_employees_on_public_id", unique: true
    t.index ["role"], name: "index_employees_on_role"
  end

  create_table "tasks", force: :cascade do |t|
    t.uuid "public_id", default: -> { "uuid_generate_v4()" }, null: false
    t.string "title", null: false
    t.integer "status", limit: 2, default: 0, null: false
    t.bigint "assignee_id", null: false
    t.integer "assignment_fee", null: false
    t.integer "completion_reward", null: false
    t.datetime "assigned_at", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jira_id"
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
  end

end

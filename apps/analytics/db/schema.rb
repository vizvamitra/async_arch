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

ActiveRecord::Schema[7.0].define(version: 2023_08_21_010008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "dimensions_accounts", force: :cascade do |t|
    t.string "public_id", null: false
    t.string "owner_public_id"
    t.integer "category", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_dimensions_accounts_on_category"
    t.index ["public_id"], name: "index_dimensions_accounts_on_public_id", unique: true
  end

  create_table "dimensions_dates", force: :cascade do |t|
    t.datetime "timestamp", null: false
    t.datetime "minute", null: false
    t.datetime "hour", null: false
    t.date "day", null: false
    t.date "week", null: false
    t.date "month", null: false
    t.date "quarter", null: false
    t.date "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day"], name: "index_dimensions_dates_on_day"
    t.index ["hour"], name: "index_dimensions_dates_on_hour"
    t.index ["minute"], name: "index_dimensions_dates_on_minute"
    t.index ["month"], name: "index_dimensions_dates_on_month"
    t.index ["quarter"], name: "index_dimensions_dates_on_quarter"
    t.index ["timestamp"], name: "index_dimensions_dates_on_timestamp", unique: true
    t.index ["week"], name: "index_dimensions_dates_on_week"
    t.index ["year"], name: "index_dimensions_dates_on_year"
  end

  create_table "dimensions_employees", force: :cascade do |t|
    t.string "public_id", null: false
    t.integer "role", limit: 2
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_id"], name: "index_dimensions_employees_on_public_id", unique: true
    t.index ["role"], name: "index_dimensions_employees_on_role"
  end

  create_table "dimensions_tasks", force: :cascade do |t|
    t.string "public_id", null: false
    t.string "title"
    t.string "jira_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_id"], name: "index_dimensions_tasks_on_public_id", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "identity_id"
    t.string "public_id", null: false
    t.string "email"
    t.integer "role", limit: 2
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["identity_id"], name: "index_employees_on_identity_id"
    t.index ["public_id"], name: "index_employees_on_public_id", unique: true
    t.index ["role"], name: "index_employees_on_role"
  end

  create_table "facts_account_balance_changed_facts", force: :cascade do |t|
    t.bigint "date_id", null: false
    t.bigint "employee_id"
    t.bigint "account_id", null: false
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_facts_account_balance_changed_facts_on_account_id"
    t.index ["date_id"], name: "index_facts_account_balance_changed_facts_on_date_id"
    t.index ["employee_id"], name: "index_facts_account_balance_changed_facts_on_employee_id"
  end

  create_table "facts_task_completion_reward_paid_facts", force: :cascade do |t|
    t.bigint "date_id", null: false
    t.bigint "employee_id"
    t.bigint "task_id", null: false
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date_id"], name: "index_facts_task_completion_reward_paid_facts_on_date_id"
    t.index ["employee_id"], name: "index_facts_task_completion_reward_paid_facts_on_employee_id"
    t.index ["task_id"], name: "index_facts_task_completion_reward_paid_facts_on_task_id"
  end

end

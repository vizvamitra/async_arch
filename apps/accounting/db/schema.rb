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

ActiveRecord::Schema[7.0].define(version: 2023_08_27_133232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounting_periods", force: :cascade do |t|
    t.string "description"
    t.date "start", null: false
    t.date "end", null: false
    t.boolean "closed", default: false, null: false
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["closed"], name: "index_accounting_periods_on_closed", unique: true, where: "(closed IS FALSE)"
  end

  create_table "accounts", force: :cascade do |t|
    t.uuid "public_id", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "owner_id"
    t.string "name", null: false
    t.integer "number", null: false
    t.integer "category", limit: 2, null: false
    t.integer "natural_balance", limit: 2, null: false
    t.integer "contra", limit: 2, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["number"], name: "index_accounts_on_number"
    t.index ["owner_id"], name: "index_accounts_on_owner_id", unique: true
    t.index ["public_id"], name: "index_accounts_on_public_id", unique: true
  end

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

  create_table "entries", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "transfer_id", null: false
    t.integer "amount", null: false
    t.integer "side", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_entries_on_account_id"
    t.index ["side"], name: "index_entries_on_side"
    t.index ["transfer_id"], name: "index_entries_on_transfer_id"
  end

  create_table "financial_statements", force: :cascade do |t|
    t.integer "kind", limit: 2, null: false
    t.bigint "accounting_period_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounting_period_id"], name: "index_financial_statements_on_accounting_period_id"
    t.index ["kind", "accounting_period_id"], name: "index_financial_statements_on_kind_and_accounting_period_id", unique: true
  end

  create_table "payment_cycles", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.boolean "closed", default: false, null: false
    t.datetime "closed_at"
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "closed"], name: "index_payment_cycles_on_employee_id_and_closed", unique: true, where: "(closed IS FALSE)"
    t.index ["employee_id", "date"], name: "index_payment_cycles_on_employee_id_and_date", unique: true
  end

  create_table "statement_line_items", force: :cascade do |t|
    t.bigint "statement_id", null: false
    t.integer "section", limit: 2, null: false
    t.string "label", null: false
    t.integer "amount", null: false
    t.integer "section_position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["statement_id"], name: "index_statement_line_items_on_statement_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "public_id", null: false
    t.string "title"
    t.string "jira_id"
    t.integer "assignment_fee", null: false
    t.integer "completion_reward", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.uuid "public_id", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "kind", limit: 2
    t.string "description", null: false
    t.string "reference_type"
    t.bigint "reference_id"
    t.bigint "accounting_period_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accounting_period_id"], name: "index_transfers_on_accounting_period_id"
    t.index ["kind"], name: "index_transfers_on_kind"
    t.index ["public_id"], name: "index_transfers_on_public_id"
    t.index ["reference_type", "reference_id"], name: "index_transfers_on_reference"
  end

end

class CreateStarTables < ActiveRecord::Migration[7.0]
  def change
    create_table :dimensions_employees do |t|
      t.string :public_id, null: false
      t.integer :role, limit: 2
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps

      t.index :public_id, unique: true
      t.index :role
    end

    create_table :dimensions_tasks do |t|
      t.string :public_id, null: false
      t.string :title
      t.string :jira_id

      t.timestamps

      t.index :public_id, unique: true
    end

    create_table :dimensions_accounts do |t|
      t.string :public_id, null: false
      t.string :owner_public_id
      t.integer :category, limit: 2

      t.timestamps

      t.index :public_id, unique: true
      t.index :category
    end

    create_table :dimensions_dates do |t|
      t.datetime :timestamp, null: false
      t.datetime :minute, null: false
      t.datetime :hour, null: false
      t.date :day, null: false
      t.date :week, null: false
      t.date :month, null: false
      t.date :quarter, null: false
      t.date :year, null: false

      t.timestamps

      t.index :timestamp, unique: true
      t.index :minute
      t.index :hour
      t.index :day
      t.index :week
      t.index :month
      t.index :quarter
      t.index :year
    end

    create_table :facts_task_completion_reward_paid_facts do |t|
      t.references :date, null: false
      t.references :employee
      t.references :task, null: false
      t.integer :amount

      t.timestamps
    end

    create_table :facts_account_balance_changed_facts do |t|
      t.references :date, null: false
      t.references :employee
      t.references :account, null: false
      t.integer :balance

      t.timestamps
    end
  end
end

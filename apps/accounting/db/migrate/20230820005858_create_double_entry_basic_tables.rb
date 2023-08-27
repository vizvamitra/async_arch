class CreateDoubleEntryBasicTables < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :accounts do |t|
      t.uuid :public_id, null: false, default: "uuid_generate_v4()"
      t.references :owner, index: false
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :category, null: false, limit: 2
      t.integer :natural_balance, null: false, limit: 2
      t.integer :contra, null: false, default: 1, limit: 2

      t.timestamps

      t.index :public_id, unique: true
      t.index :number
      t.index :name, unique: true
      t.index :owner_id, unique: true
    end

    create_table :entries do |t|
      t.references :account, null: false
      t.references :transfer, null: false
      t.integer :amount, null: false
      t.integer :side, null: false, limit: 2

      t.timestamps

      t.index :side
    end

    create_table :transfers do |t|
      t.uuid :public_id, null: false, default: "uuid_generate_v4()"
      t.integer :kind, limit: 2
      t.string :description, null: false
      t.references :reference, polymorphic: true
      t.references :accounting_period, null: false

      t.timestamps

      t.index :public_id
      t.index :kind
    end

    create_table :accounting_periods do |t|
      t.string :description
      t.date :start, null: false
      t.date :end, null: false
      t.boolean :closed, null: false, default: false
      t.datetime :closed_at

      t.timestamps

      t.index %i[closed], unique: true, where: "closed IS FALSE"
    end

    create_table :financial_statements do |t|
      t.integer :kind, limit: 2, null: false
      t.references :accounting_period, null: false

      t.timestamps

      t.index %i[kind accounting_period_id], unique: true
    end

    create_table :statement_line_items do |t|
      t.references :statement, null: false, index: true
      t.integer :section, limit: 1, null: false
      t.string :label, null: false
      t.integer :amount, null: false
      t.integer :section_position, null: false

      t.timestamps
    end
  end
end

class CreateDoubleEntryBasicTables < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :accounts do |t|
      t.uuid :public_id, null: false, default: "uuid_generate_v4()"
      t.references :owner
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :category, null: false, limit: 2
      t.integer :natural_balance, null: false, limit: 2
      t.integer :contra, null: false, default: 1, limit: 2

      t.timestamps

      t.index :public_id, unique: true
      t.index :number
      t.index :name, unique: true
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
      t.string :description, null: false
      t.references :reference, polymorphic: true
      t.date :date, null: false, index: true

      t.timestamps
    end
  end
end

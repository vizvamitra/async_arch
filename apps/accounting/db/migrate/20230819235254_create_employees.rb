class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :identity
      t.string :public_id, null: false
      t.string :email
      t.integer :role, limit: 2
      t.string :first_name
      t.string :last_name

      t.timestamps

      t.index :email, unique: true
      t.index :role
      t.index :public_id, unique: true
    end
  end
end

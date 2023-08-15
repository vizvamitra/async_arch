class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :tasks do |t|
      t.uuid :public_id, null: false, default: "uuid_generate_v4()"
      t.string :description, null: false
      t.integer :status, null: false, limit: 2, default: 0
      t.references :assignee, null: false
      t.integer :assignment_fee, null: false
      t.integer :completion_reward, null: false
      t.datetime :assigned_at, null: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :public_id, null: false
      t.string :title
      t.string :jira_id
      t.integer :assignment_fee, null: false
      t.integer :completion_reward, null: false

      t.timestamps
    end
  end
end

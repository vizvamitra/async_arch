class RemovePriceColumnsFromTasks < ActiveRecord::Migration[7.0]
  def up
    remove_column :tasks, :assignment_fee, :integer
    remove_column :tasks, :completion_reward, :integer
  end
end

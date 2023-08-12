class ChangeTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :assignment_price, :assignment_fee
    add_column :tasks, :assigned_at, :datetime
    reversible { |d| d.up { execute("UPDATE tasks SET assigned_at = NOW()") } }
    change_column_null :tasks, :assigned_at, false
  end
end

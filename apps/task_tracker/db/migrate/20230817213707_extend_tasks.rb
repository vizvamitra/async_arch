class ExtendTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :jira_id, :string
    # In a real project, I'd do this in steps, but that's irrelevant for that
    # course
    rename_column :tasks, :description, :title
  end
end

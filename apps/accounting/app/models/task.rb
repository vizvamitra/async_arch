class Task < ApplicationRecord
  validates :public_id, presence: true

  def title_with_jira_id
    jira_id ? "[#{jira_id}] #{title}" : title
  end
end

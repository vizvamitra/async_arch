# frozen_string_literal: true

class Task < ApplicationRecord
  enum status: { in_progress: 0, completed: 1 }

  belongs_to :assignee, class_name: "Employee", inverse_of: :tasks

  validates :status, :assignee, :assignment_fee, :completion_reward,
            presence: true
end

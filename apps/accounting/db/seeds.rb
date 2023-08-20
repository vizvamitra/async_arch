[
  ["Cash", :asset, Accounts::Numbers::CASH],
  ["Capital", :equity, Accounts::Numbers::CAPITAL],
  ["Task Assignment Fees", :revenue, Accounts::Numbers::TASK_ASSIGNMENT_FEES],
  ["Task Completion Rewards", :expense, Accounts::Numbers::TASK_COMPLETION_REWARDS],
  ["Income Sumary", :temporary, Accounts::Numbers::INCOME_SUMMARY]
].each do |name, category, number|
  Accounts::Create.new.call(name:, category:, number:)
end

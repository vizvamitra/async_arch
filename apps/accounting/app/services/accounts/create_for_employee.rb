module Accounts
  class CreateForEmployee
    NAME_FORMAT = "Employee %<id>s -- Available funds"

    def initialize(create_account: Create.new)
      @_create_account = create_account
    end

    # @param employee [Employee]
    #
    # @return [Account]
    # @raise [ActiveRecord::RecordInvalid]
    #
    def call(employee:)
      _create_account.call(
        owner: employee,
        name: format(NAME_FORMAT, id: employee.public_id),
        category: :liability,
        number: Numbers::EMPLOYEE
      )
    end

    private

    attr_reader :_create_account
  end
end

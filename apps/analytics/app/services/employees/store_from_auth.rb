module Employees
  class StoreFromAuth
    def initialize(store: Store.new)
      @store = store
    end

    # @param identity [Auth::Identity]
    # @param info [Auth::Info]
    #
    # @return [Employee]
    # @raise [KeyError]
    #
    def call(identity:, info:)
      ActiveRecord::Base.transaction do
        employee = store.call(**info.to_h)
        employee.update!(identity:)

        employee
      end
    end

    private

    attr_reader :store
  end
end

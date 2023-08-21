module Dimensions
  module Dates
    class Store
      # @param timestamp [DateTime]
      #
      # @return [Dimensions::Date]
      #
      def call(timestamp:)
        time = timestamp.to_time

        Dimensions::Date
          .create_with(
            minute: time.beginning_of_minute,
            hour: time.beginning_of_hour,
            day: time.beginning_of_day,
            week: time.beginning_of_week,
            month: time.beginning_of_month,
            quarter: time.beginning_of_quarter,
            year: time.beginning_of_year
          )
          .create_or_find_by!(timestamp:)
      end
    end
  end
end

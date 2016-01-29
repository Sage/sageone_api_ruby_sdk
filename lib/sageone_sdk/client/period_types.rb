module SageoneSdk
  class Client

    # Represents the rate frequency in Sage One and refers to the chargeable
    # period of a service. For example, hourly or daily.
    module PeriodTypes

      # @return [object] Returns all rate frequencies.
      def period_types(options = {})
        get "period_types", options
      end

      # @return [object] Returns the rate frequency with the given id.
      def period_type(id, options = {})
        get "period_types/#{id}", options
      end
    end
  end
end

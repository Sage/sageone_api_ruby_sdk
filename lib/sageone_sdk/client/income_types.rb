module SageoneSdk
  class Client

    # Represents types of sale in Sage One. These are the categories
    # a user can make sales against.
    module IncomeTypes

      # @return [object] Returns all sales types.
      def income_types(options = {})
        get "income_types", options
      end

      # @return [object] Returns the sales type with the given id.
      def income_type(id, options = {})
        get "income_types/#{id}", options
      end
    end
  end
end

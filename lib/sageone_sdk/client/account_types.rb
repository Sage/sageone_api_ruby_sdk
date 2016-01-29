module SageoneSdk
  class Client

    # Represents the bank account types in Sage One.
    # For example, Savings or Cash in Hand.
    module AccountTypes

      # @return [object] Returns all of the bank account types in Sage One.
      def account_types(options = {})
        get "account_types", options
      end

      # @return [object] Returns the bank account type with the given id.
      def account_type(id, options = {})
        get "account_types/#{id}", options
      end
    end
  end
end

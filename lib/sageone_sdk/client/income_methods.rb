module SageoneSdk
  class Client

    # Represents the payment methods available when recording a sale.
    # For example, bank receipt.
    module IncomeMethods

      # @return [object] Returns all payment methods.
      def income_methods(options = {})
        get "income_methods", options
      end

      # @return [object] Returns the payment method with the given id.
      def income_method(id, options = {})
        get "income_methods/#{id}", options
      end
    end
  end
end

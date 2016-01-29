module SageoneSdk
  class Client

    # Represents the payment methods available when recording a purchase.
    # For example, credit card payment.
    module ExpenseMethods

      # @return [object] Returns all payment methods.
      def expense_methods(options = {})
        get "expense_methods", options
      end

      # @return [object] Returns the payment method with the given id.
      def expense_method(id, options = {})
        get "expense_methods/#{id}", options
      end
    end
  end
end

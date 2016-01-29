module SageoneSdk
  class Client

    # Represents the transactions for the authenticated user's business.
    module Transactions

      # @return [object] Returns all transactions for the authenticated user's business.
      def transactions(options = {})
        get "transactions", options
      end
    end
  end
end

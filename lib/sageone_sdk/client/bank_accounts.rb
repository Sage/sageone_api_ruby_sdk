module SageoneSdk
  class Client

    # Represents the bank accounts for the authenticated user's business.
    module BankAccounts

      # @return [object] Returns all bank accounts for the authenticated user's business.
      def bank_accounts(options = {})
        paginate "bank_accounts", options
      end

      # @return [object] Returns the bank account with the given id.
      def bank_account(id, options = {})
        get "bank_accounts/#{id}", options
      end
    end
  end
end

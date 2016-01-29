module SageoneSdk
  class Client

    # Represents ledger accounts for the authenticated user's business.
    module LedgerAccounts

      # @return [object] Returns all ledger accounts for the authenticated user's business.
      def ledger_accounts(options = {})
        get "ledger_accounts", options
      end

      # @return [object] Returns the ledger account with the given id.
      def ledger_account(id, options = {})
        get "ledger_accounts/#{id}", options
      end

      # @return [object] Returns all ledger accounts with a balance for the given date range.
      # @param options [hash]
      # @option options [date] from_date The transaction from date.
      # @option options [date] to_date The transaction to date.
      # @example Get balances for January 2015
      #   @client.ledger_account_balances({'from_date' => '2015-01-01', 'to_date' => '2015-01-31'})
      def ledger_account_balances(options = {})
        get "ledger_accounts/balances", options
      end

      # @return [object] Returns the given ledger account and its balance for the given date range.
      # @param id [integer] The ledger account id.
      # @param options [hash]
      # @option options [date] from_date The transaction from date.
      # @option options [date] to_date The transaction to date.
      # @example Get balances for ledger account id 1233 for January 2015
      #   @client.ledger_account_balances(1233, {'from_date' => '2015-01-01', 'to_date' => '2015-01-31'})
      def ledger_account_balance(id, options = {})
        get "ledger_accounts/#{id}/balance", options
      end

      # Creates a ledger account with the data provided.
      # @example Create a new ledger account
      #   @client.create_ledger_account({ledger_name: "My new ledger account",
      #                                  display_name: "My new ledger account",
      #                                  nominal_code: 1235,
      #                                  included_in_chart: true,
      #                                  category_id: 1})
      # @param data [hash] The ledger account information.
      # @param options [hash]
      def create_ledger_account(data, options = {})
        post "ledger_accounts", :ledger_account => data
      end
    end
  end
end

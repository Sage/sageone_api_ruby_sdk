module SageoneSdk
  class Client

    # Represents the chart of accounts. This is a list 
    # of all of the accounts used by your business. It defines the structure
    # of your income, expenditure, assets, liabilities and capital when
    # running your management reports.
    module ChartOfAccounts

      # @return [object] Returns all chart of accounts templates.
      def coa_templates(options = {})
        get "coa_templates", options
      end

      # @return [object] Returns the chart of accounts for the authenticated user's business.
      def coa_structure(options = {})
        get "coa_structure", options
      end
    end
  end
end

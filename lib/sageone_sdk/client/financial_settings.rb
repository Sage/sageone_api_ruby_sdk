module SageoneSdk
  class Client

    # Represents the financial settings in Sage One. This includes
    # year end date and tax schemes.
    module FinancialSettings

      # @return [object] Returns the financial settings.
      def financial_settings(options = {})
        get "financial_settings", options
      end

      # Updates the financial settings with the data provided.
      # @example Change the year end date
      #   @client.update_financial_settings({"year_end_date" => "2016-12-31"})
      # @param data [hash] The settings information to update.
      # @param options [hash]
      def update_financial_settings(data, options = {})
        put "financial_settings", :financial_settings => data
      end
    end
  end
end

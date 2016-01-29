module SageoneSdk
  class Client

    # Represents the tax rates in Sage One. For example, standard or zero-rated.
    module TaxRates

      # @return [object] Returns all tax rates.
      def tax_rates(options = {})
        get "tax_rates", options
      end

      # @return [object] Returns the tax rate with the given id.
      def tax_rate(id, options = {})
        get "tax_rates/#{id}", options
      end
    end
  end
end

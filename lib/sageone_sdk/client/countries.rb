module SageoneSdk
  class Client

    # Represents the countries available to select in Sage One.
    module Countries

      # @return [object] Returns all countries.
      def countries(options = {})
        get "countries", options
      end

      # @return [object] Returns the country with the given id.
      def country(id, options = {})
        get "countries/#{id}", options
      end
    end
  end
end

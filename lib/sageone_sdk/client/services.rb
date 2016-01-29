module SageoneSdk
  class Client

    # Represents the services for the authenticated user's business.
    module Services

      # @return [object] Returns all services for the authenticated user's business.
      def services(options = {})
        paginate "services", options
      end

      # @return [object] Returns the service record with the given id.
      def service(id, options = {})
        get "services/#{id}", options
      end

      # Creates a service record with the data provided.
      # @example Create a new service record
      #   @client.create_service({description: "My new service",
      #                           rate_includes_tax: false,
      #                           ledger_account_id: 438,
      #                           tax_code_id: 1,
      #                           period_rate_price: 99.99})
      # @param data [hash] The service record information.
      # @param options [hash]
      def create_service(data, options = {})
        post "services", :service => data
      end

      # Updates the given service record with the data provided.
      # @example Update a service record description
      #   @client.update_service(11232, {description: "My updated service"})
      # @param id [integer] The id of the service record to update.
      # @param data [hash] The service information to update.
      # @param options [hash]
      def update_service(id, data, options = {})
        put "services/#{id}", :service => data
      end

      # Deletes the given service record.
      # @param id [integer] The id of the service record to delete.
      # @param options [hash]
      def delete_service(id, options = {})
        delete "services/#{id}"
      end
    end
  end
end

module SageoneSdk
  class Client

    # Represents the products for the authenticated user's business.
    module Products

      # @return [object] Returns all products for the authenticated user's business.
      def products(options = {})
        paginate "products", options
      end

      # @return [object] Returns the product with the given id.
      def product(id, options = {})
        get "products/#{id}", options
      end

      # Creates a product record with the data provided.
      # @example Create a new product record
      #   @client.create_product({description: "My new product",
      #                           sales_price_includes_tax: false,
      #                           ledger_account_id: 438,
      #                           tax_code_id: 1,
      #                           product_code: "PROD001",
      #                           last_cost_price: 41.5,
      #                           sales_price: 99.99})
      # @param data [hash] The product record information.
      # @param options [hash]
      def create_product(data, options = {})
        post "products", :product => data
      end

      # Updates the given product record with the data provided.
      # @example Update a product sales price
      #   @client.update_product(2341, {sales_price: 199.99})
      # @param id [integer] The id of the product record to update.
      # @param data [hash] The product information to update.
      # @param options [hash]
      def update_product(id, data, options = {})
        put "products/#{id}", :product => data
      end

      # Deletes the given product record.
      # @param id [integer] The id of the product record to delete.
      # @param options [hash]
      def delete_product(id, options = {})
        delete "products/#{id}"
      end
    end
  end
end

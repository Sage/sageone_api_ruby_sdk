module SageoneSdk
  class Client

    # Represents other income transactions for the authenticated user's business.
    module Incomes

      # @return [object] Returns all other income transactions for the authenticated user's business.
      def incomes(options = {})
        paginate "incomes", options
      end

      # @return [object] Returns the other income transaction with the given id.
      def income(id, options = {})
        get "incomes/#{id}", options
      end

      # Creates an other income transaction with the data provided.
      # @example Create a new income transaction
      #   @client.create_income({"date" => "2016-01-25",
      #                          "amount" => 100.0,
      #                          "tax_amount" => 20.0,
      #                          "tax_percentage_rate" => 20.0,
      #                          "tax_code_id" => 1,
      #                          "source_id" => 434,
      #                          "destination_id" => 415,
      #                          "payment_method_id" => 2})
      # @param data [hash] The transaction information.
      # @param options [hash]
      def create_income(data, options = {})
        post "incomes", :income => data
      end

      # Updates the given transaction with the data provided.
      # @example Update the date of an income transaction
      #   @client.update_income(655324, {"date" => "2016-01-31"})
      # @param id [integer] The id of the income transaction to update.
      # @param data [hash] The transaction information to update.
      # @param options [hash]
      def update_income(id, data, options = {})
        put "incomes/#{id}", :income => data
      end

      # Deletes the given income transaction.
      # @param id [integer] The id of the income transaction to delete.
      # @param options [hash]
      def delete_income(id, options = {})
        delete "incomes/#{id}"
      end
    end
  end
end

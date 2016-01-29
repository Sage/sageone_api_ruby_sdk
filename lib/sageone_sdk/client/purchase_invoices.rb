module SageoneSdk
  class Client

    # Represents the purchase invoices for the authenticated user's business.
    module PurchaseInvoices

      # @return [object] Returns all purchase invoices for the authenticated user's business.
      def purchase_invoices(options = {})
        paginate "purchase_invoices", options
      end

      # @return [object] Returns the purchase invoice with the given id.
      def purchase_invoice(id, options = {})
        get "purchase_invoices/#{id}", options
      end

      # Creates a purchase invoice with the data provided.
      # @example Create a new purchase invoice
      #   @client.create_purchase_invoice({"contact_id" => "371",
      #                                    "contact_name" => "Bob's Building Supplies",
      #                                    "due_date" => "2016-01-31",
      #                                    "date" => "2016-01-01",
      #                                    "line_items_attributes[0][description]" => "Line item description",
      #                                    "line_items_attributes[0][quantity]" => 10.0,
      #                                    "line_items_attributes[0][unit_price]" => 19.5,
      #                                    "line_items_attributes[0][tax_code_id]" => 1,
      #                                    "line_items_attributes[0][ledger_account_id]" => 434})
      # @param data [hash] The purchase invoice information.
      # @param options [hash]
      def create_purchase_invoice(data, options = {})
        lines = data.delete(:line_items)

        if lines
          data[:line_items_attributes] = {}
          lines.each_with_index do |value, index|
            data[:line_items_attributes][index] = value
          end
        end

        post "purchase_invoices", :purchase_invoice => data
      end

      # Updates the given purchase invoice with the data provided.
      # @example Update a purchase invoice due_date
      #   @client.update_purchase_invoice(11243, {"due_date" => "2016-01-31"})
      # @param id [integer] The id of the purchase invoice to update.
      # @param data [hash] The purchase invoice information to update.
      # @param options [hash]
      def update_purchase_invoice(id, data, options = {})
        put "purchase_invoices/#{id}", :purchase_invoice => data
      end

      # Deletes the purchase invoice with the given id.
      # @param id [integer] The id of the purchase invoice to delete.
      # @param options [hash]
      def delete_purchase_invoice(id, options = {})
        delete "purchase_invoices/#{id}"
      end
    end
  end
end

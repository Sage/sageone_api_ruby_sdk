module SageoneSdk
  class Client

    # Represents the sales invoices for the authenticated user's business.
    module SalesInvoices

      # @return [object] Returns all sales invoices for the authenticated user's business.
      def sales_invoices(options = {})
        paginate "sales_invoices", options
      end

      # @return [object] Returns the sales invoice with the given id.
      def sales_invoice(id, options = {})
        get "sales_invoices/#{id}", options
      end

      # Creates a sales invoice with the data provided.
      # @example Create a new sales invoice
      #   @client.create_sales_invoice({"contact_id" => "237",
      #                                 "contact_name" => "My best customer",
      #                                 "due_date" => "2016-01-31",
      #                                 "date" => "2016-01-01",
      #                                 "main_address" => "25 Station Road...",
      #                                 "carriage_tax_code_id" => 1,
      #                                 "line_items_attributes[0][description]" => "Line item description",
      #                                 "line_items_attributes[0][product_id]" => 17,
      #                                 "line_items_attributes[0][product_code]" => "PROD001",
      #                                 "line_items_attributes[0][quantity]" => 10.0,
      #                                 "line_items_attributes[0][unit_price]" => 29.5,
      #                                 "line_items_attributes[0][tax_code_id]" => 1,
      #                                 "line_items_attributes[0][ledger_account_id]" => 434})
      # @param data [hash] The sales invoice information.
      # @param options [hash]
      def create_sales_invoice(data, options = {})
        lines = data.delete(:line_items)

        if lines
          data[:line_items_attributes] = {}
          lines.each_with_index do |value, index|
            data[:line_items_attributes][index] = value
          end
        end

        post "sales_invoices", :sales_invoice => data
      end

      # Updates the given sales invoice with the data provided.
      # @example Update a sales invoice due_date
      #   @client.update_sales_invoice(1243, {"due_date" => "2016-01-31"})
      # @param id [integer] The id of the sales invoice to update.
      # @param data [hash] The sales invoice information to update.
      # @param options [hash]
      def update_sales_invoice(id, data, options = {})
        put "sales_invoices/#{id}", :sales_invoice => data
      end

      # Deletes the sales invoice with the given id.
      # @param id [integer] The id of the sales invoice to delete.
      # @param options [hash]
      def delete_sales_invoice(id, options = {})
        delete "sales_invoices/#{id}"
      end
    end
  end
end

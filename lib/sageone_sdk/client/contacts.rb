module SageoneSdk
  class Client
    # Represents the contacts for the authenticated user's business.
    module Contacts

      # @return [object] Returns all contacts for the authenticated user's business.
      def contacts(options = {})
        paginate "contacts", options
      end

      # @return [object] Returns the contact with the given id.
      def contact(id, options = {})
        get "contacts/#{id}", options
      end

      # @return [object] Returns all customers for the authenticated user's business.
      def customers(options = {})
        options["contact_type_id"] = ContactTypes::CUSTOMER

        contacts(options)
      end

      # @return [object] Returns all suppliers for the authenticated user's business.
      def suppliers(options = {})
        options["contact_type_id"] = ContactTypes::SUPPLIER

        contacts(options)
      end

      # Creates a contact record with the data provided.
      # @example Create a new contact record
      #   @client.create_contact(1, {"name" => "My new customer",
      #                              "company_name" => "Sage UK Ltd"})
      # @param type [integer] The contact type id. 1 = Customer, 2 = Supplier.
      # @param data [hash] The contact record information.
      # @param options [hash]
      def create_contact(type, data, options = {})
        data['contact_type_id'] = type

        post "contacts", :contact => data
      end

      # Creates a customer record with the data provided.
      # @example Create a new customer record
      #   @client.create_customer({"name" => "My new customer",
      #                            "company_name" => "Sage UK Ltd"})
      # @param data [hash] The customer record information.
      # @param options [hash]
      def create_customer(data, options = {})
        create_contact(ContactTypes::CUSTOMER, data, options)
      end

      # Creates a supplier record with the data provided.
      # @example Create a new supplier record
      #   @client.create_supplier({"name" => "My new supplier",
      #                            "company_name" => "Sage UK Ltd"})
      # @param data [hash] The supplier record information.
      # @param options [hash]
      def create_supplier(data, options = {})
        create_contact(ContactTypes::SUPPLIER, data, options)
      end

      # Updates the given contact record with the data provided.
      # @example Update contact record with id 1234
      #   @client.update_contact(1234, {"name" => "Updated contact name",
      #                                 "company_name" => "Updated company name"})
      # @param id [integer] The id of the contact record to update.
      # @param data [hash] The contact record information to update.
      # @param options [hash]
      def update_contact(id, data, options = {})
        put "contacts/#{id}", :contact => data
      end

      # Deletes the given contact record.
      # @param id [integer] The id of the contact record to delete.
      # @param options [hash]
      def delete_contact(id, options = {})
        delete "contacts/#{id}"
      end
    end
  end
end

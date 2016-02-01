module SageoneSdk
  class Client

    # Represents the types of contact records in Sage One such as Customer or Supplier.
    module ContactTypes
      # Customer Contact Type
      CUSTOMER = 1.freeze
      # Supplier Contact Type
      SUPPLIER = 2.freeze

      # @return [object] Returns all of the contact types in Sage One. For example, Customer.
      def contact_types(options = {})
        get "contact_types", options
      end

      # @return [object] Returns the contact type with the given id.
      def contact_type(id, options = {})
        get "contact_types/#{id}", options
      end
    end
  end
end

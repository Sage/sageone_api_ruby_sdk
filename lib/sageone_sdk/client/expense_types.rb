module SageoneSdk
  class Client

    # Represents types of expense in Sage One. These are the categories
    # a user can make purchases against.
    module ExpenseTypes

      # @return [object] Returns all expense types.
      def expense_types(options = {})
        get "expense_types", options
      end

      # @return [object] Returns the expense type with the given id.
      def expense_type(id, options = {})
        get "expense_types/#{id}", options
      end
    end
  end
end

module SageoneSdk
  class Client
    # Expenditures
    module Expenditures
      # @return [object] Returns paginated expenditures for the authenticated user's business.
      def expenditures(options = {})
        paginate "expenditures", options
      end

      # @return [object] Returns the expenditure with the given id.
      def expenditure(id, options = {})
        get "expenditures/#{id}", options
      end

      # Creates an expenditure with the data provided
      # @param [hash] data The expenditure information
      # @param [hash] options
      def create_expenditure(data, options = {})
        post "expenditures", :expenditure => data
      end

      # Updates an expenditure with the data provided
      # @param [integer] id The expenditure id
      # @param [hash] data The expenditure information
      # @param [hash] options
      def update_expenditure(id, data, options = {})
        put "expenditures/#{id}", :expenditure => data
      end

      # Deletes the specified expenditure
      # @param [integer] id The expenditure id
      # @param [hash] options
      def delete_expenditure(id, options = {})
        delete "expenditures/#{id}"
      end
    end
  end
end

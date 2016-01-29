module SageoneSdk
  class Client
    module Expenditures
      def expenditures(options = {})
        paginate "expenditures", options
      end

      def expenditure(id, options = {})
        get "expenditures/#{id}", options
      end

      def create_expenditure(data, options = {})
        post "expenditures", :expenditure => data
      end

      def update_expenditure(id, data, options = {})
        put "expenditures/#{id}", :expenditure => data
      end

      def delete_expenditure(id, options = {})
        delete "expenditures/#{id}"
      end
    end
  end
end

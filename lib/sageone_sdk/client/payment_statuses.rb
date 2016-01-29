module SageoneSdk
  class Client

    # Represents the payment status of an invoice in Sage One. For example, Paid or Void.
    module PaymentStatuses

      # @return [object] Returns all payment statuses.
      def payment_statuses(options = {})
        get "payment_statuses", options
      end

      # @return [object] Returns the payment status with the given id.
      def payment_status(id, options = {})
        get "payment_statuses/#{id}", options
      end
    end
  end
end

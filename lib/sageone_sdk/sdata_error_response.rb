module SageoneSdk
  # SData error response
  class SDataErrorResponse
    attr_reader :data

    def initialize(data = {})
      @data = data
    end

    # Diagnoses
    def diagnoses
      @data["$diagnoses"]
    end

    # Full Messages
    def full_messages
      diagnoses.map do |x|
        "#{x["$source"].humanize}: #{x["$message"]}"
      end
    end

    # Error?
    # @return Boolean
    def error?
      true
    end

    # Respond to missing?
    # @return Boolean
    def respond_to_missing?(method, include_private =  false)
      resources.respond_to?(method, include_private)
    end

    # Handle method missing
    def method_missing(method, *args, &block)
      if diagnoses.respond_to?(method)
        diagnoses.send(method, *args)
      else
        super
      end
    end
  end
end

module SageoneSdk
  # SData response
  class SDataResponse
    attr_reader :data

    def initialize(data = {})
      @data = data
    end

    # Total Results
    def total_results
      @data["$totalResults"]
    end

    # Starting Index
    def start_index
      @data["startIndex"]
    end

    # Items Per Page
    def items_per_page
      @data["$itemsPerPage"]
    end

    # Resources
    def resources
      @data["$resources"]
    end

    # Error?
    # @return Boolean
    def error?
      false
    end

    # Find By
    # @param conditions
    def find_by(conditions)
      resources.detect do |resource|
        @skip = false
        conditions.each do |field, value|
          unless resource.public_send(field) == value
            @skip = true
            break
          end
        end

        !@skip
      end
    end

    # Respond to missing?
    # @return Boolean
    def respond_to_missing?(method, include_private =  false)
      resources.respond_to?(method, include_private) || data.respond_to?(method, include_private)
    end

    # Handle method missing
    def method_missing(method, *args, &block)
      if resources.respond_to?(method)
        resources.send(method, *args)
      elsif data.respond_to?(method)
        data.send(method, *args)
      else
        super
      end
    end
  end
end

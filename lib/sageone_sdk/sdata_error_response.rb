module SageoneSdk
  class SDataErrorResponse
    attr_reader :data

    def initialize(data = {})
      @data = data
    end

    def diagnoses
      @data["$diagnoses"]
    end

    def full_messages
      diagnoses.map do |x|
        "#{x["$source"].humanize}: #{x["$message"]}"
      end
    end

    def error?
      true
    end

    def respond_to_missing?(method, include_private =  false)
      resources.respond_to?(method, include_private)
    end

    def method_missing(method, *args, &block)
      if diagnoses.respond_to?(method)
        diagnoses.send(method, *args)
      else
        super
      end
    end
  end
end

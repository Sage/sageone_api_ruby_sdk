module SageoneSdk
  # Configurable
  module Configurable
    attr_accessor :access_token, :connection_options, :default_media_type, :user_agent, :signing_secret

    attr_writer :api_endpoint

    class << self
      def keys
        @keys ||= [
          :access_token,
          :signing_secret,
          :api_endpoint,
          :connection_options,
          :default_media_type,
          :user_agent
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      SageoneSdk::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", SageoneSdk::Default.options[key])
      end
      self
    end
    alias :setup :reset!

    def api_endpoint
      File.join(@api_endpoint, "")
    end

    private

    def options
      Hash[SageoneSdk::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end

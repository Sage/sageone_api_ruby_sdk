require 'sageone_sdk/version'

module SageoneSdk
  # Default
  module Default
    ACCESS_TOKEN = "ACCESS_TOKEN"
    SIGNING_SECRET = "default_signing_secret"
    API_ENDPOINT = "https://api.sageone.com".freeze
    USER_AGENT = "sageone_sdk Ruby Gem #{SageoneSdk::VERSION}".freeze
    MEDIA_TYPE = "application/json"

    class << self
      def options
        Hash[SageoneSdk::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def access_token
        ENV["SAGE_ONE_ACCESS_TOKEN"] || ACCESS_TOKEN
      end

      def signing_secret
        ENV["SAGE_ONE_SIGNING_SECRET"] || SIGNING_SECRET
      end

      def api_endpoint
        ENV["SAGE_ONE_API_ENDPOINT"] || API_ENDPOINT
      end

      def default_media_type
        ENV["SAGE_ONE_DEFAULT_MEDIA_TYPE"] || MEDIA_TYPE
      end

      def user_agent
        ENV["SAGE_ONE_USER_AGENT"] || USER_AGENT
      end

      def connection_options
        {
          :headers => {
            :accept => default_media_type,
            :user_agent => user_agent
          }
        }
      end
    end
  end
end

require 'sageone_sdk/signature'
require 'sageone_sdk/sdata_error_response'
require 'sageone_sdk/sdata_response'
require "json"
require "hashie/mash"

module SageoneSdk
  module Middleware
    class SDataParser < Faraday::Middleware
      def call(environment)
        @app.call(environment).on_complete do |env|
          element = ::JSON.parse(env[:body])

          if element.respond_to?(:each_pair)
            response_body = Hashie::Mash.new(element)
            if env.success?
              env[:body] = SageoneSdk::SDataResponse.new(response_body)
            else
              env[:body] = SageoneSdk::SDataErrorResponse.new(response_body)
            end
          else
            env[:body] = element.map { |x| Hashie::Mash.new(x) }
          end
        end
      end
    end
  end
end

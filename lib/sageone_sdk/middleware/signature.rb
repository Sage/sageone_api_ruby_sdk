require 'sageone_sdk/signature'
require "active_support/core_ext"

module SageoneSdk
  module Middleware
    # Signature
    class Signature < Faraday::Middleware
      def initialize(app, access_token, signing_secret)
        super(app)

        @access_token = access_token
        @signing_secret = signing_secret
      end

      def call(env)
        nonce = SageoneSdk::Signature.generate_nonce
        signature = SageoneSdk::Signature.new(env.method, env.url, env.body, nonce, @signing_secret, @access_token)

        env[:request_headers]['X-Nonce'] = nonce
        env[:request_headers]['X-Signature'] = signature.to_s

        @app.call(env)
      end
    end
  end
end

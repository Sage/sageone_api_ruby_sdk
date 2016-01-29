require "sageone_sdk/client"
require "sageone_sdk/default"

module SageoneSdk
  autoload :SDataResponse, "sageone_sdk/sdata_response"
  class << self
    include SageoneSdk::Configurable

    def client
      @client = SageoneSdk::Client.new unless defined?(@client)
      @client
    end
  end
end

SageoneSdk.setup

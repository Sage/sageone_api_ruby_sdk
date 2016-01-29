require "sageone_sdk/client"
require "sageone_sdk/default"
# SageoneSdk
module SageoneSdk
  autoload :SDataResponse, "sageone_sdk/sdata_response"
  class << self
    include SageoneSdk::Configurable

    # Returns an instance of SageoneSdk::Client
    def client
      @client = SageoneSdk::Client.new unless defined?(@client)
      @client
    end
  end
end

SageoneSdk.setup

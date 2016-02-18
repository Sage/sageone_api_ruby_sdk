require 'spec_helper'

describe SageoneSdk do

  describe "configurable" do
    it "can be configured" do
      SageoneSdk.configure do |config|
        config.access_token = "foo"
      end
      expect(SageoneSdk.access_token).to eq("foo")
    end
  end

  describe "client" do
    it "returns a new client" do
      expect(SageoneSdk.client).to be_kind_of(SageoneSdk::Client)
    end
  end
end

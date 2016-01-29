require 'spec_helper'

describe SageoneSdk::Client::IncomeMethods do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "income_methods", :vcr do
    it "returns all income_methods" do
      income_methods = client.income_methods
      expect(income_methods.first.name).not_to be_nil
    end
  end

  describe "income_methods/:id", :vcr do
    before :each do
      VCR.use_cassette('income_methods_index') do
        @income_method_id = client.income_methods.first.id
      end
    end

    it "returns a specific contact type" do
      income_method = client.income_method(@income_method_id)
      expect(income_method.name).to eq("Bank Receipt")
    end
  end
end

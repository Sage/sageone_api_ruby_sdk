require 'spec_helper'

describe SageoneSdk::Client::AccountTypes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "account_types", :vcr do
    it "returns all account_types" do
      account_types = client.account_types
      expect(account_types.first.name).not_to be_nil
    end
  end

  describe "account_types/:id", :vcr do
    before :each do
      VCR.use_cassette('account_types_index') do
        @account_type_id = client.account_types.first.id
      end
    end

    it "returns a specific account type" do
      account_type = client.account_type(@account_type_id)
      expect(account_type.name).to eq("Current")
    end
  end
end

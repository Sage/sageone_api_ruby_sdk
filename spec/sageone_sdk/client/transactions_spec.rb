require 'spec_helper'

describe SageoneSdk::Client::Transactions do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar"}) }

  describe "transactions", :vcr do
    it "returns all transactions" do
      transactions = client.transactions
      expect(transactions.first.total).not_to be_nil
    end
  end
end

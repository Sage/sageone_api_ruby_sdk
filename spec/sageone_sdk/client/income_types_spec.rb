require 'spec_helper'

describe SageoneSdk::Client::IncomeTypes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "income_types", :vcr do
    it "returns all income_types" do
      income_types = client.income_types
      expect(income_types.first.name).not_to be_nil
    end
  end

  describe "income_types/:id", :vcr do
    before :each do
      VCR.use_cassette('income_types_index') do
        @income_type_id = client.income_types.first.id
      end
    end

    it "returns a specific contact type" do
      income_type = client.income_type(@income_type_id)
      expect(income_type.name).to eq("Sales Type A")
    end
  end
end

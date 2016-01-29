require 'spec_helper'

describe SageoneSdk::Client::PeriodTypes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "period_types", :vcr do
    it "returns all period_types" do
      period_types = client.period_types
      expect(period_types.first.name).not_to be_nil
    end
  end

  describe "period_types/:id", :vcr do
    before :each do
      VCR.use_cassette('period_types_index') do
        @period_type_id = client.period_types.first.id
      end
    end

    it "returns a specific contact type" do
      period_type = client.period_type(@period_type_id)
      expect(period_type.name).to eq("Annually")
    end
  end
end

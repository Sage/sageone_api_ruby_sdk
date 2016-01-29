require 'spec_helper'

describe SageoneSdk::Client::TaxRates do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "tax_rates", :vcr do
    it "returns all tax_rates" do
      tax_rates = client.tax_rates
      expect(tax_rates.first.name).not_to be_nil
    end
  end

  describe "tax_rates/:id", :vcr do
    before :each do
      VCR.use_cassette('tax_rates_index') do
        @tax_rate_id = client.tax_rates.first.id
      end
    end

    it "returns a specific contact type" do
      tax_rate = client.tax_rate(@tax_rate_id)
      expect(tax_rate.name).to eq("Standard")
    end
  end
end

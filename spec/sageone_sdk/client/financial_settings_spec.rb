require 'spec_helper'

describe SageoneSdk::Client::FinancialSettings do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar"}) }

  describe "financial settings", :vcr do
    it "returns the financial settings" do
      settings = client.financial_settings
      expect(settings.year_end_date).not_to be_nil
    end
  end

  describe "update financial settings", :vcr do
    it "updates the financial settings" do
      settings = client.update_financial_settings({year_end_date: "2016-12-31"})
      expect(settings.year_end_date).to eq("2016-12-31")
    end
  end
end

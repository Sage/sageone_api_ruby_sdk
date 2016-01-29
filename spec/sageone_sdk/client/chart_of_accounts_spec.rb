require 'spec_helper'

describe SageoneSdk::Client::ChartOfAccounts do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar"}) }

  describe "chart of accounts templates", :vcr do
    it "returns the chart of accounts templates" do
      coa_templates = client.coa_templates
      expect(coa_templates.first.name).not_to be_nil
    end
  end

  describe "chart of accounts structure", :vcr do
    it "returns the chart of accounts structure" do
      coa_structure = client.coa_structure
      expect(coa_structure.template.name).to eq("Small Business")
    end
  end
end

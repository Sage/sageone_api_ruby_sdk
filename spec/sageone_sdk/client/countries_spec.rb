require 'spec_helper'

describe SageoneSdk::Client::Countries do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "countries", :vcr do
    it "returns all countries" do
      countries = client.countries
      expect(countries.first.name).not_to be_nil
    end
  end

  describe "countries/:id", :vcr do
    before :each do
      VCR.use_cassette('countries_index') do
        @country_id = client.countries.first.id
      end
    end

    it "returns a specific account type" do
      country = client.country(@country_id)
      expect(country.name).to eq("Afghanistan")
    end
  end
end

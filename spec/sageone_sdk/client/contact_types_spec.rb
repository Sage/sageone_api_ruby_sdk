require 'spec_helper'

describe SageoneSdk::Client::ContactTypes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "contact_types", :vcr do
    it "returns all contact_types" do
      contact_types = client.contact_types
      expect(contact_types.first.name).not_to be_nil
    end
  end

  describe "contact_types/:id", :vcr do
    before :each do
      VCR.use_cassette('contact_types_index') do
        @contact_type_id = client.contact_types.first.id
      end
    end

    it "returns a specific contact type" do
      contact_type = client.contact_type(@contact_type_id)
      expect(contact_type.name).to eq("Customer")
    end
  end
end

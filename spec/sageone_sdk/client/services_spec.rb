require 'spec_helper'

describe SageoneSdk::Client::Services do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "services", :vcr do
    it "returns all services" do
      services = client.services
      expect(services.first.description).not_to be_nil
    end

    it "allows pagination" do
      services = client.services({ "$itemsPerPage" => 2 })
      expect(services.count).to eq(2)
    end
  end

  describe "services/:id", :vcr do
    before :each do
      VCR.use_cassette('services_index') do
        @service_id = client.services.first.id
      end
    end

    it "returns a specific service" do
      service = client.service(@service_id)
      expect(service.description).to eq("Foo")
    end
  end

  describe "create services", :vcr do
    it "creates a new service" do
      service = client.create_service(:description => "Foo")
      expect(service.description).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        service = client.create_service({})
        expect(service.error?).to eq(true)
        expect(service.full_messages).to include("Description: blank")
      end
    end
  end

  describe "update a service", :vcr do
    before :each do
      VCR.use_cassette('services_index') do
        @service_id = client.services.first.id
      end
    end

    it "updates the given service" do
      service = client.update_service(@service_id, { :description => "Bar" })
      expect(service.description).to eq("Bar")
    end
  end

  describe "delete a service", :vcr do
    before :each do
      VCR.use_cassette('service_create') do
        @service_id = client.create_service(:description => "Foo").id
      end
    end

    it "deletes the service" do
      service = client.delete_service(@service_id)
      expect(service).to_not be_nil
    end
  end
end

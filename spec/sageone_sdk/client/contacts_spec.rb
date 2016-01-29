require 'spec_helper'

describe SageoneSdk::Client::Contacts do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "contacts", :vcr do
    it "returns all contacts" do
      contacts = client.contacts
      expect(contacts.first.company_name).not_to be_nil
    end

    it "allows pagination" do
      contacts = client.contacts({ "$itemsPerPage" => 2 })
      expect(contacts.count).to eq(2)
    end
  end

  describe "contacts/:id", :vcr do
    before :each do
      VCR.use_cassette('contacts_index') do
        @contact_id = client.contacts.first.id
      end
    end

    it "returns a specific contact" do
      contact = client.contact(@contact_id)
      expect(contact.company_name).to eq("CUST0-GB")
    end
  end

  describe "create contacts", :vcr do
    it "creates a new contact" do
      contact = client.create_contact(SageoneSdk::Client::CUSTOMER, :name => "Foo")
      expect(contact.name).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        contact = client.create_contact(SageoneSdk::Client::CUSTOMER, {})
        expect(contact.error?).to eq(true)
        expect(contact.full_messages).to eq(["Company: This field is required."])
      end
    end
  end

  describe "update a contact", :vcr do
    before :each do
      VCR.use_cassette('contacts_index') do
        @contact_id = client.contacts.first.id
      end
    end

    it "updates the given contact" do
      contact = client.update_contact(@contact_id, { :name => "Bar" })
      expect(contact.name).to eq("Bar")
    end
  end

  describe "delete a contact", :vcr do
    before :each do
      VCR.use_cassette('customer_create') do
        @contact_id = client.create_customer(:name => "Foo").id
      end
    end

    it "deletes the contact" do
      contact = client.delete_contact(@contact_id)
      expect(contact).to_not be_nil
    end
  end
end

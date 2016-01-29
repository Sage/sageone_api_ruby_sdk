require 'spec_helper'

describe SageoneSdk::Client::PaymentStatuses do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "payment_statuses", :vcr do
    it "returns all payment_statuses" do
      payment_statuses = client.payment_statuses
      expect(payment_statuses.first.name).not_to be_nil
    end
  end

  describe "payment_statuses/:id", :vcr do
    before :each do
      VCR.use_cassette('payment_statuses_index') do
        @payment_status_id = client.payment_statuses.first.id
      end
    end

    it "returns a specific contact type" do
      payment_status = client.payment_status(@payment_status_id)
      expect(payment_status.name).to eq("Unpaid")
    end
  end
end

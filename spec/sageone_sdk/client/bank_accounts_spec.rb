require 'spec_helper'

describe SageoneSdk::Client::BankAccounts do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "bank_accounts", :vcr do
    it "returns all bank_accounts" do
      bank_accounts = client.bank_accounts
      expect(bank_accounts.first.account_name).not_to be_nil
    end

    it "allows pagination" do
      bank_accounts = client.bank_accounts({ "$itemsPerPage" => 2 })
      expect(bank_accounts.count).to eq(2)
    end
  end

  describe "bank_accounts/:id", :vcr do
    before :each do
      VCR.use_cassette('bank_accounts_index') do
        @bank_account_id = client.bank_accounts.first.id
      end
    end

    it "returns a specific bank account" do
      bank_account = client.bank_account(@bank_account_id)
      expect(bank_account.account_name).to eq("Current")
    end
  end
end

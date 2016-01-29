require 'spec_helper'

describe SageoneSdk::Client::LedgerAccounts do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "ledger_accounts", :vcr do
    it "returns all ledger_accounts" do
      ledger_accounts = client.ledger_accounts
      expect(ledger_accounts.first.name).not_to be_nil
    end
  end

  describe "ledger_accounts/:id", :vcr do
    before :each do
      VCR.use_cassette('ledger_accounts_index') do
        @ledger_account_id = client.ledger_accounts.first.id
      end
    end

    it "returns a specific ledger account" do
      ledger_account = client.ledger_account(@ledger_account_id)
      expect(ledger_account.name).to eq("IT equipment cost")
    end
  end

  describe "ledger_account_balances", :vcr do
    it "returns ledger accounts with a balance" do
      ledger_account_balances = client.ledger_account_balances({from_date: '2015-01-01', to_date: '2016-01-01'})
      expect(ledger_account_balances.first.balance).to eq("12575.0")
    end

    it "does not return ledger accounts with a zero balance" do
      ledger_account_zero_balances = client.ledger_account_balances({from_date: '2010-01-01', to_date: '2010-01-01'})
      expect(ledger_account_zero_balances.length).to eq(0)
    end
  end

  describe "create a ledger account", :vcr do
    let(:data) do
      {ledger_name: "My new ledger account",
       display_name: "My new ledger account",
       nominal_code: 1235,
       included_in_chart: true,
       category_id: 1}
    end

    it "creates a new ledger account" do
      ledger_account = client.create_ledger_account(data)
      expect(ledger_account.name).to eq("My new ledger account")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        ledger_account = client.create_ledger_account({})

        expect(ledger_account.error?).to eq(true)
        expect(ledger_account.full_messages).to include("Name: This field is required.")
      end
    end
  end
end

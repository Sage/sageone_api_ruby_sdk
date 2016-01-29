require 'spec_helper'

describe SageoneSdk::Client::Incomes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  let(:source) do
    VCR.use_cassette('ledger_accounts_index') do
      client.ledger_accounts.find_by(:name => "Sales")
    end
  end

  let(:destination) do
    VCR.use_cassette('bank_accounts_index') do
      client.bank_accounts.find_by(:account_name => "Current").ledger_account
    end
  end

  let(:payment_method) do
    VCR.use_cassette('income_methods_index') do
      client.income_methods.find_by(:name => "Bank Receipt")
    end
  end

  let(:tax_rate) do
    VCR.use_cassette('tax_rates_index') do
      client.tax_rates.find_by(:name => "Lower Rate")
    end
  end

  let(:data) do
    {
      :date => Date.today.strftime("%d/%m/%Y"),
      :amount => 100,
      :tax_amount => 20,
      :tax_percentage_rate => tax_rate.percentage,
      :tax_code_id => tax_rate.id,
      :source_id => source.id,
      :destination_id => destination.id,
      :payment_method_id => payment_method.id,
      :reference => "Foo"
    }
  end

  describe "incomes", :vcr do
    it "returns all incomes" do
      incomes = client.incomes
      expect(incomes.first.reference).not_to be_nil
    end

    it "allows pagination" do
      incomes = client.incomes({ "$itemsPerPage" => 2 })
      expect(incomes.count).to eq(2)
    end
  end

  describe "incomes/:id", :vcr do
    before :each do
      VCR.use_cassette('incomes_index') do
        @income_id = client.incomes.first.id
      end
    end

    it "returns a specific income" do
      income = client.income(@income_id)
      expect(income.reference).to eq("I12345")
    end
  end

  describe "create incomes", :vcr do
    it "creates a new income" do
      income = client.create_income(data)

      expect(income.reference).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        income = client.create_income({})
        expect(income.error?).to eq(true)
        expect(income.full_messages).to include("Source: blank")
      end
    end
  end

  describe "update an income", :vcr do
    before :each do
      VCR.use_cassette('incomes_index') do
        @income_id = client.incomes.first.id
      end
    end

    it "updates the given income" do
      income = client.update_income(@income_id, { :reference => "Bar" })
      expect(income.reference).to eq("Bar")
    end
  end

  describe "delete an income", :vcr do
    before :each do
      VCR.use_cassette('income_create') do
        @income_id = client.create_income(data).id
      end
    end

    it "deletes the income" do
      income = client.delete_income(@income_id)
      expect(income).to_not be_nil
    end
  end
end

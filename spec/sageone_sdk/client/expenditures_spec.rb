require 'spec_helper'

describe SageoneSdk::Client::Expenditures do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  let(:source) do
    VCR.use_cassette('bank_accounts_index') do
      client.bank_accounts.find_by(:account_name => "Current").ledger_account
    end
  end

  let(:destination) do
    VCR.use_cassette('ledger_accounts_index') do
      client.ledger_accounts.find_by(:name => "Energy")
    end
  end

  let(:payment_method) do
    VCR.use_cassette('expense_methods_index') do
      client.expense_methods.find_by(:name => "Bank Payment")
    end
  end

  let(:tax_rate) do
    VCR.use_cassette('tax_rates_index') do
      client.tax_rates.find_by(:name => "Lower Rate")
    end
  end

  let(:data) do
    {
      :source_id => source.id,
      :tax_code_id => tax_rate.id,
      :destination_id => destination.id,
      :date => Date.today.strftime("%d/%m/%Y"),
      :amount => 58.00,
      :tax_amount => 2.90,
      :tax_percentage_rate => tax_rate.percentage,
      :reference => "Foo",
      :payment_method_id => payment_method.id
    }
  end

  describe "expenditures", :vcr do
    it "returns all expenditures" do
      expenditures = client.expenditures
      expect(expenditures.first.reference).not_to be_nil
    end

    it "allows pagination" do
      expenditures = client.expenditures({ "$itemsPerPage" => 2 })
      expect(expenditures.count).to eq(2)
    end
  end

  describe "expenditures/:id", :vcr do
    before :each do
      VCR.use_cassette('expenditures_index') do
        @expenditure_id = client.expenditures.first.id
      end
    end

    it "returns a specific expenditure" do
      expenditure = client.expenditure(@expenditure_id)
      expect(expenditure.reference).to eq("Energy bill")
    end
  end

  describe "create expenditures", :vcr do
    it "creates a new expenditure" do
      expenditure = client.create_expenditure(data)
      expect(expenditure.reference).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        expenditure = client.create_expenditure({})
        expect(expenditure.error?).to eq(true)
        expect(expenditure.full_messages).to include("Source: blank")
      end
    end
  end

  describe "update an expenditure", :vcr do
    before :each do
      VCR.use_cassette('expenditures_index') do
        @expenditure_id = client.expenditures.first.id
      end
    end

    it "updates the given expenditure" do
      expenditure = client.update_expenditure(@expenditure_id, { :reference => "Bar" })
      expect(expenditure.reference).to eq("Bar")
    end
  end

  describe "delete an expenditure", :vcr do
    before :each do
      VCR.use_cassette('expenditure_create') do
        @expenditure_id = client.create_expenditure(data).id
      end
    end

    it "deletes the expenditure" do
      expenditure = client.delete_expenditure(@expenditure_id)
      expect(expenditure).to_not be_nil
    end
  end
end

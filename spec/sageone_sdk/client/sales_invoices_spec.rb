require 'spec_helper'

describe SageoneSdk::Client::SalesInvoices do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  let(:contact) do
    VCR.use_cassette('customers_index') do
      client.customers.first
    end
  end

  let(:tax_rate) do
    VCR.use_cassette('tax_rates_index') do
      client.tax_rates.find_by(:name => "Standard")
    end
  end

  let(:ledger_account) do
    VCR.use_cassette('ledger_accounts_index') do
      client.ledger_accounts.find_by(:name => "Sales")
    end
  end

  let(:line_items) do
    [
      {
        :description => "A1",
        :quantity => 1,
        :unit_price => 10,
        :tax_code_id => tax_rate.id,
        :ledger_account_id => ledger_account.id
      },
      {
        :description => "B1",
        :quantity => 5,
        :unit_price => 9.99,
        :tax_code_id => tax_rate.id,
        :ledger_account_id => ledger_account.id
      }
    ]
  end

  let(:data) do
    {
      :reference => "Foo",
      :date => Date.today.strftime("%d/%m/%Y"),
      :due_date => 15.days.from_now.strftime("%d/%m/%Y"),
      :contact_id => contact.id,
      :contact_name => contact.name,
      :main_address => "Main Address",
      :carriage_tax_code_id => tax_rate.id,
      :line_items => line_items
    }
  end

  describe "sales_invoices", :vcr do
    it "returns all sales invoices" do
      sales_invoices = client.sales_invoices
      expect(sales_invoices.first.invoice_number).not_to be_nil
    end

    it "allows pagination" do
      sales_invoices = client.sales_invoices({ "$itemsPerPage" => 2 })
      expect(sales_invoices.count).to eq(2)
    end
  end

  describe "sales_invoices/:id", :vcr do
    before :each do
      VCR.use_cassette('sales_invoices_index') do
        @sales_invoice_id = client.sales_invoices.last.id
      end
    end

    it "returns a specific sales invoice" do
      sales_invoice = client.sales_invoice(@sales_invoice_id)
      expect(sales_invoice.reference).to eq("Ref12345")
    end
  end

  describe "create sales_invoices", :vcr do
    it "creates a new sales invoice" do
      sales_invoice = client.create_sales_invoice(data)
      expect(sales_invoice.reference).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        sales_invoice = client.create_sales_invoice({})
        expect(sales_invoice.error?).to eq(true)
        expect(sales_invoice.full_messages).to include("Date: invalid date")
      end
    end
  end

  describe "update a sales invoice", :vcr do
    before :each do
      VCR.use_cassette('sales_invoices_index') do
        @sales_invoice_id = client.sales_invoices.first.id
      end
    end

    it "updates the given sales invoice" do
      sales_invoice = client.update_sales_invoice(@sales_invoice_id, { :reference => "Bar" })
      expect(sales_invoice.reference).to eq("Bar")
    end
  end

  describe "delete a sales invoice", :vcr do
    before :each do
      VCR.use_cassette('sales_invoice_create') do
        s = client.create_sales_invoice(data)
        @sales_invoice_id = s.id
      end
    end

    it "deletes the sales invoice" do
      sales_invoice = client.delete_sales_invoice(@sales_invoice_id)
      expect(sales_invoice).to_not be_nil
    end
  end
end

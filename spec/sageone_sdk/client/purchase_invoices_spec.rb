require 'spec_helper'

describe SageoneSdk::Client::PurchaseInvoices do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  let(:contact) do
    VCR.use_cassette('suppliers_index') do
      client.suppliers.first
    end
  end

  let(:tax_rate) do
    VCR.use_cassette('tax_rates_index') do
      client.tax_rates.find_by(:name => "Standard")
    end
  end

  let(:ledger_account) do
    VCR.use_cassette('ledger_accounts_index') do
      client.ledger_accounts.find_by(:name => "Energy")
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
      :line_items => line_items
    }
  end

  describe "purchase_invoices", :vcr do
    it "returns all purchase invoices" do
      purchase_invoices = client.purchase_invoices
      expect(purchase_invoices.first.reference).not_to be_nil
    end

    it "allows pagination" do
      purchase_invoices = client.purchase_invoices({ "$itemsPerPage" => 2 })
      expect(purchase_invoices.count).to eq(2)
    end
  end

  describe "purchase_invoices/:id", :vcr do
    before :each do
      VCR.use_cassette('purchase_invoices_index') do
        @purchase_invoice_id = client.purchase_invoices.first.id
      end
    end

    it "returns a specific purchase invoice" do
      purchase_invoice = client.purchase_invoice(@purchase_invoice_id)
      expect(purchase_invoice.reference).to eq("Foo")
    end
  end

  describe "create purchase_invoices", :vcr do
    it "creates a new purchase invoice" do
      purchase_invoice = client.create_purchase_invoice(data)
      expect(purchase_invoice.reference).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        purchase_invoice = client.create_purchase_invoice({})
        expect(purchase_invoice.error?).to eq(true)
        expect(purchase_invoice.full_messages).to include("Date: invalid date")
      end
    end
  end

  describe "update a purchase invoice", :vcr do
    before :each do
      VCR.use_cassette('purchase_invoices_index') do
        @purchase_invoice_id = client.purchase_invoices.first.id
      end
    end

    it "updates the given purchase invoice" do
      purchase_invoice = client.update_purchase_invoice(@purchase_invoice_id, { :reference => "Bar" })
      expect(purchase_invoice.reference).to eq("Bar")
    end
  end

  describe "delete a purchase invoice", :vcr do
    before :each do
      VCR.use_cassette('purchase_invoice_create') do
        s = client.create_purchase_invoice(data)
        @purchase_invoice_id = s.id
      end
    end

    it "deletes the purchase invoice" do
      purchase_invoice = client.delete_purchase_invoice(@purchase_invoice_id)
      expect(purchase_invoice).to_not be_nil
    end
  end
end

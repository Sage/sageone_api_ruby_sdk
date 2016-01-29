require 'spec_helper'

describe SageoneSdk::Client::ExpenseMethods do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "expense_methods", :vcr do
    it "returns all expense_methods" do
      expense_methods = client.expense_methods
      expect(expense_methods.first.name).not_to be_nil
    end
  end

  describe "expense_methods/:id", :vcr do
    before :each do
      VCR.use_cassette('expense_methods_index') do
        @expense_method_id = client.expense_methods.first.id
      end
    end

    it "returns a specific contact type" do
      expense_method = client.expense_method(@expense_method_id)
      expect(expense_method.name).to eq("Bank Payment")
    end
  end
end

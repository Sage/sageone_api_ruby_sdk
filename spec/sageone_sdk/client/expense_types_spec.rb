require 'spec_helper'

describe SageoneSdk::Client::ExpenseTypes do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "expense_types", :vcr do
    it "returns all expense_types" do
      expense_types = client.expense_types
      expect(expense_types.first.name).not_to be_nil
    end
  end

  describe "expense_types/:id", :vcr do
    before :each do
      VCR.use_cassette('expense_types_index') do
        @expense_type_id = client.expense_types.first.id
      end
    end

    it "returns a specific contact type" do
      expense_type = client.expense_type(@expense_type_id)
      expect(expense_type.name).to eq("Assets - Cost")
    end
  end
end

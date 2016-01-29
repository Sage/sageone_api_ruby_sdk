require 'spec_helper'

describe SageoneSdk::Client::Journals do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar"}) }

  describe "journals", :vcr do
    let(:data) do
      {"reference" => "ref001",
       "description" => "description",
       "date" => "2016-01-01",
       "journal_lines[0][credit]" => 50.0,
       "journal_lines[0][debit]" => 0.0,
       "journal_lines[0][details]" => "detail",
       "journal_lines[0][ledger_account][nominal_code]" => 1,
       "journal_lines[1][credit]" => 0.0,
       "journal_lines[1][debit]" => 50.0,
       "journal_lines[1][details]" => "detail",
       "journal_lines[1][ledger_account][nominal_code]" => 9999}
    end
    
    it "creates a journal" do
      journal = client.create_journal(data)
      expect(journal.reference).not_to be_nil
    end

    context "on error" do
      it "responds with an appropriate error message" do
        journal = client.create_journal({"foo" => "bar"})

        expect(journal.error?).to eq(true)
        expect(journal.full_messages).to eq(["Base: invalid_date"])
      end
    end
  end
end

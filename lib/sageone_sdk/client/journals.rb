module SageoneSdk
  class Client

    # Represents journal trasnactions in Sage One.
    module Journals

      # Creates a journal entry with the data provided.
      # @example Create a new journal transaction
      #   @client.create_journal({"reference" => "ref001",
      #                           "description" => "description",
      #                           "date" => "2016-01-01",
      #                           "journal_lines[0][credit]" => 50.0,
      #                           "journal_lines[0][debit]" => 0.0,
      #                           "journal_lines[0][details]" => "detail",
      #                           "journal_lines[0][ledger_account][nominal_code]" => 1,
      #                           "journal_lines[1][credit]" => 0.0,
      #                           "journal_lines[1][debit]" => 50.0,
      #                           "journal_lines[1][details]" => "detail",
      #                           "journal_lines[1][ledger_account][nominal_code]" => 9999})
      # @param data [hash] The journal entry information.
      # @param options [hash]
      def create_journal(data, options = {})
        post "journals", :journal => data
      end
    end
  end
end

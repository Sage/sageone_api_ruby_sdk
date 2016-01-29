require "sawyer"
require "faraday_middleware"
require "sageone_sdk/authentication"
require "sageone_sdk/configurable"
require "sageone_sdk/middleware"
require "sageone_sdk/client/account_types"
require "sageone_sdk/client/bank_accounts"
require "sageone_sdk/client/chart_of_accounts"
require "sageone_sdk/client/contact_types"
require "sageone_sdk/client/contacts"
require "sageone_sdk/client/countries"
require "sageone_sdk/client/expenditures"
require "sageone_sdk/client/expense_methods"
require "sageone_sdk/client/expense_types"
require "sageone_sdk/client/financial_settings"
require "sageone_sdk/client/income_methods"
require "sageone_sdk/client/income_types"
require "sageone_sdk/client/incomes"
require "sageone_sdk/client/journals"
require "sageone_sdk/client/ledger_accounts"
require "sageone_sdk/client/payment_statuses"
require "sageone_sdk/client/period_types"
require "sageone_sdk/client/purchase_invoices"
require "sageone_sdk/client/products"
require "sageone_sdk/client/sales_invoices"
require "sageone_sdk/client/services"
require "sageone_sdk/client/tax_rates"
require "sageone_sdk/client/transactions"

module SageoneSdk
  # Client
  class Client
    include SageoneSdk::Authentication
    include SageoneSdk::Configurable
    include SageoneSdk::Client::AccountTypes
    include SageoneSdk::Client::BankAccounts
    include SageoneSdk::Client::ChartOfAccounts
    include SageoneSdk::Client::ContactTypes
    include SageoneSdk::Client::Contacts
    include SageoneSdk::Client::Countries
    include SageoneSdk::Client::Expenditures
    include SageoneSdk::Client::ExpenseMethods
    include SageoneSdk::Client::ExpenseTypes
    include SageoneSdk::Client::FinancialSettings
    include SageoneSdk::Client::IncomeMethods
    include SageoneSdk::Client::IncomeTypes
    include SageoneSdk::Client::Incomes
    include SageoneSdk::Client::Journals
    include SageoneSdk::Client::LedgerAccounts
    include SageoneSdk::Client::PaymentStatuses
    include SageoneSdk::Client::PeriodTypes
    include SageoneSdk::Client::PurchaseInvoices
    include SageoneSdk::Client::Products
    include SageoneSdk::Client::SalesInvoices
    include SageoneSdk::Client::Services
    include SageoneSdk::Client::TaxRates
    include SageoneSdk::Client::Transactions

    def initialize(options = {})
      SageoneSdk::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || SageoneSdk.instance_variable_get(:"@#{key}"))
      end
    end

    def last_response
      @last_response if defined? @last_response
    end

    def paginate(resource, options = {})
      data = get(resource, options)
      data
    end

    def get(path, data={})
      request(:get, path, data)
    end

    def post(path, data={})
      request(:post, path, data)
    end

    def put(path, data={})
      request(:put, path, data)
    end

    def delete(path, data={})
      request(:delete, path, data)
    end

    def request(method, path, data, options = {})
      path = File.join("accounts", "v1", path)
      @last_response = response = agent.public_send(method, URI::Parser.new.escape(path.to_s), data, options)
      response.body
    end

    def agent
      @agent ||= Faraday.new(api_endpoint, faraday_options) do |builder|
        builder.request :url_encoded
        builder.headers['Accept'] = default_media_type
        builder.headers['Content-Type'] = "application/x-www-form-urlencoded"
        builder.headers['User-Agent'] = user_agent
        if token_authenticated?
          builder.authorization 'Bearer', @access_token
        end
        builder.use SageoneSdk::Middleware::Signature, access_token, signing_secret
        builder.use SageoneSdk::Middleware::SDataParser
        builder.adapter Faraday.default_adapter
      end
    end

    private

    def faraday_options
      {}
    end
  end
end

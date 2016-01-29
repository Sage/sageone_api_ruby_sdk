# SageoneSdk

[![Build Status](https://travis-ci.org/Sage/sageone_api_ruby_sdk.svg?branch=master)](https://travis-ci.org/Sage/sageone_api_ruby_sdk)

The `sageone_sdk` gem provides Ruby methods for accessing the Sage One API endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sageone_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sageone_sdk

## Usage

To create a `SageoneSdk::Client`, you need to provide your access_token and signing_secret:

```
@client = SageoneSdk::Client.new({access_token: @access_token,
                                  signing_secret: @signing_secret})
```

Further information about obtaining these is available [here](https://developers.sageone.com/docs/en/v1#overview).

You can then call the required method on the `@client`:

```
@client.bank_accounts
=> #<SageoneSdk::SDataResponse:0x007faaa9eb1760
   @data=
    {"$totalResults"=>2,
     "$startIndex"=>0,
     "$itemsPerPage"=>20,
     "$resources"=>
      [{"id"=>214227,
        "account_name"=>"Current",
        #...}]
    }>
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sageone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

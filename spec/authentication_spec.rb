require 'spec_helper'
describe "authentication" do

  describe "token_authenticated?" do
    let(:access_token) {"2c1cf3aaaeaa2618ea37"}
    it "returns true when an access_token is set" do
      client = SageoneSdk::Client.new({ access_token: access_token })
      expect(client.token_authenticated?).to be_truthy
    end
  end

  describe "Correctly forms authorization_url" do
    let(:client_id) {"2c1cf3aaaeaa2618ea37"}
    let(:client_secret) {"dbdb48ddd20602564e74e5d29e8ebfcae4aee3f2"}
    let(:redirect_uri) {"http://foo/callback"}
    let(:formatted_url){"https://www.sageone.com/oauth2/auth?"\
      "response_type=code&"\
      "client_id=2c1cf3aaaeaa2618ea37&"\
      "redirect_uri=http://foo/callback&"\
      "scope=full_access"}
    specify do
      client = SageoneSdk::Client.new({ client_id: client_id,
                                    client_secret: client_secret,
                                    redirect_uri: redirect_uri})
      expect(client.authorization_url). to eql formatted_url
    end
  end
end
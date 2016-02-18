module SageoneSdk
  # Authentication
  module Authentication
    # Checks if access token is nil
    def token_authenticated?
      !!@access_token
    end
    # Forms the authorization_uri using the client's attributes
    def authorization_url
      "https://www.sageone.com/oauth2/auth?"\
      "response_type=code&"\
      "client_id=#{@client_id}&"\
      "redirect_uri=#{redirect_uri}&"\
      "scope=full_access"
    end
    # Calls token_request to request an access token using the authorization code
    # @param [string] authorisation code returned from authorization request
    def request_access_token (code)
      token_request("access_token", {code: code})
    end
    # Calls token_request to request an access token using a refresh token
    # @param [string] refresh_token
    def refresh_access_token(refresh_token)
      token_request("refresh_token")
    end

    # Makes a POST request to retrieve an access token and refresh token
    # @param [string] type of token request, either a new access token or refresh
    # @param [hash] option to pass a code if requesting a new access_token
    def token_request(type, options = {})
      request = Faraday.new() do |builder|
        builder.request :url_encoded
        builder.response :json, :content_type => /\bjson$/
        builder.adapter Faraday.default_adapter
      end
      if type == "access_token"
         payload = {client_id: @client_id,
                      client_secret: @client_secret,
                      code: options[:code],
                      grant_type: 'authorization_code',
                      redirect_uri: @redirect_uri}
      elsif type == "refresh_token"
        payload = {client_id: @client_id,
                      client_secret: @client_secret,
                      refresh_token: @refresh_token,
                      grant_type: 'refresh_token'}
      end
      json_response = request.post "#{api_endpoint}/oauth2/token", payload
      return json_response.body
    end
  end
end

module SageoneSdk
  # Authentication
  module Authentication
    def token_authenticated?
      !!@access_token
    end

    def authorization_url
      "https://www.sageone.com/oauth2/auth?response_type=code&client_id=#{@client_id}&redirect_uri=#{redirect_uri}&scope=full_access"
    end

    def request_access_token (code)
      token_request("access_token", {code: code})
    end

    def refresh_access_token(refresh_token)
      token_request("refresh_token")
    end

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
      json_response = request.post 'https://api.sageone.com/oauth2/token', payload
      return json_response.body
    end
  end
end

require 'base64'
require 'openssl'
require 'cgi'

module SageoneSdk
  # Signature
  class Signature
    attr_reader :http_method, :nonce

    # Constructor
    def initialize(http_method, url, request_body, nonce, secret, token)
      @http_method = http_method.to_s.upcase
      @url = URI(url)
      @request_body = request_body.to_s
      @nonce = nonce
      @secret = secret
      @token = token
    end

    # Generate Nonce
    def self.generate_nonce
      SecureRandom.hex
    end

    # Set the base URL
    def base_url
      base_array = []
      base_array << @url.scheme
      base_array << "://"
      base_array << @url.host
      base_array << ":#{@url.port}" if @url.port != @url.default_port
      base_array << @url.path

      base_array.join
    end

    # Request query params
    def query_params
      get_params_hash(@url.query)
    end

    # Request body params
    def body_params
      get_params_hash(@request_body)
    end

    # Generate the request params from the request query and body params
    def request_params
      request_hash = query_params.merge(body_params).sort
      request_array = []

      request_hash.each do |key, value|
        request_array << "#{key}=#{value}"
      end

      request_array.join('&')
    end

    # Generate the base signature string
    def signature_base_string
      s = @http_method.dup
      s << '&'
      s << percent_encode(base_url)
      s << '&'
      s << percent_encode(request_params.to_s)
      s << '&'
      s << percent_encode(nonce.to_s)

      s
    end

    # Generate the signing key
    def signing_key
      s = percent_encode(@secret)
      s << '&'
      s << percent_encode(@token)

      s
    end

    # Generates the signature
    def to_s
      s = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), signing_key, signature_base_string))

      s
    end

    private

    # Generates a hash from a params string
    def get_params_hash(params)
      params_hash = {}

      if !params.nil? and !params.empty?
        params = percent_decode(params)
        params.split('&').each do |param|
          param_pair = param.split('=')
          params_hash[percent_encode(param_pair[0])] = percent_encode(param_pair[1])
        end
      end

      params_hash
    end

    # Percent encodes special characters in a string
    def percent_encode(str)
      # Replaced deprecated URI.escape with CGI.escape
      # CGI.escape replaces spaces with "+", so we also need to substitute them with "%20"
      CGI.escape(str).gsub("+", "%20")
    end

    def percent_decode(str)
      CGI.unescape(str).gsub("%20", "+")
    end
  end
end

struct Mailjet
  struct Client
    getter api_key : String?
    getter secret_key : String?

    # Initialize with credentials
    #
    # ```crystal
    # client = Mailjet::Client.new("my_key", "my_secret")
    # ```
    #
    # Or without, if credentials are configured globally:
    #
    # ```crystal
    # client = Mailjet::Client.new
    # ```
    def initialize(
      @api_key = Config.api_key,
      @secret_key = Config.secret_key
    )
      unless api_key && secret_key
        raise MissingApiCredentialsException.new(
          "Both an API key and secret key are required")
      end
    end

    def handle_api_call(
      method : String,
      path : String,
      query : Hash | NamedTuple = {} of String => String,
      payload : Hash | NamedTuple = {} of String => String,
      headers : Hash | NamedTuple = {} of String => String
    )
      client = http_client(URI.parse(Config.end_point))

      request_headers = http_headers
      headers.each { |key, value| request_headers[key.to_s] = value }

      path += "?#{Utilities.query_parameterize(query)}" unless query.empty?

      begin
        if {"GET", "DELETE"}.includes?(method)
          response = client.exec(method, path,
            headers: request_headers)
        else
          payload = payload.to_h.delete_if { |_, v| v.nil? }.to_json
          response = client.exec(method, path,
            headers: request_headers,
            body: payload)
        end
        render(response)
      rescue e : IO::TimeoutError
        raise RequestTimeoutException.new(e.message)
      rescue e : IO::EOFError
        raise Exception.new(e.message)
      end
    end

    private def http_headers
      HTTP::Headers{
        "Accept"          => "application/json",
        "Content-Type"    => "application/json",
        "Accept-Encoding" => "deflate",
        "User-Agent"      => "mailjet-api-v3-crystal/#{VERSION}",
      }
    end

    private def http_client(uri : URI)
      client = HTTP::Client.new(uri)
      client.read_timeout = Config.read_timeout
      client.connect_timeout = Config.open_timeout
      client.basic_auth(@api_key, @secret_key)
      client
    end

    private def render(response : HTTP::Client::Response)
      case response.status_code
      when 200, 201
        response.body.empty? ? "{}" : response.body
      when 204
        ""
      when 404
        raise ResourceNotFoundException.from_json(response.body)
      else
        raise RequestException.from_json(ensure_error_response(response))
      end
    end

    private def ensure_error_response(response : HTTP::Client::Response)
      return response.body unless response.body.blank?
      %({
        "ErrorMessage": "Something went wrong",
        "StatusCode": #{response.status_code}
      })
    end

    # Create a new instance with given api credentials
    def self.with_credentials(
      api_key : String?,
      secret_key : String?
    )
      new(api_key, secret_key)
    end

    # Create a new instance with given api credentials and a block
    # def self.with_credentials(api_key : String?)
    #   yield(Mailjet::Proxy.new(with_credentials(api_key)))
    # end
  end
end

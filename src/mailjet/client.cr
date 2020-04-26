struct Mailjet
  struct Client
    getter path : String
    getter api_key : String?
    getter secret_key : String?
    getter read_only : Bool
    getter public_operations : Array(String)

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
      @path,
      @public_operations,
      @api_key = Config.api_key,
      @secret_key = Config.secret_key,
      @read_only = false
    )
      unless api_key && secret_key
        raise MissingApiCredentialsException.new(
          "Both an API key and secret key are required")
      end
    end

    def get(headers = Alias::HS2.new)
      handle_api_call("GET", headers)
    end

    def post(
      payload = Alias::HS2.new,
      headers = Alias::HS2.new
    )
      handle_api_call("POST", headers, payload)
    end

    def put(
      payload = Alias::HS2.new,
      headers = Alias::HS2.new
    )
      handle_api_call("PUT", headers, payload)
    end

    def delete(headers = Alias::HS2.new)
      handle_api_call("DELETE", headers)
    end

    private def handle_api_call(
      method : String,
      headers : Hash | NamedTuple = Alias::HS2.new,
      payload : Hash | NamedTuple = Alias::HS2.new
    )
      unless method_allowed?(method)
        raise MethodNotAllowedException.new("Method #{method} is not allowed")
      end

      client = http_client(URI.parse(Config.end_point))
      api_path = "/#{path.lchop("/")}"

      request_headers = http_headers
      headers.each { |key, value| request_headers[key.to_s] = value }

      begin
        response = client.exec(method, api_path, headers: request_headers)
        if payload.empty?
          # else
          #   response = client.exec(method, api_path, headers: request_headers, body: payload)
        end
        render(response)
        # rescue e : IO::Timeout
        #   raise RequestTimeoutException.new(e.message)
      rescue e : IO::EOFError
        raise Exception.new(e.message)
      end
    end

    private def method_allowed?(method : String)
      public_operations.includes?(method) && (method == "GET" || !read_only)
    end

    private def http_headers
      HTTP::Headers{
        "Accept"       => "application/json",
        "Content-Type" => "application/json",
      }
    end

    private def http_client(uri : URI)
      client = HTTP::Client.new(uri)
      client.read_timeout = Config.read_timeout
      client.connect_timeout = Config.open_timeout
      client
    end

    private def render(response : HTTP::Client::Response)
      case response.status_code
      when 200, 201
        # response.body.empty? ? "{}" : response.body
      when 204
        # ""
      when 404
        # body = %({"message":"Resource missing"})
        # raise ResourceNotFoundException.from_json(body)
      else
        # body = response.body.blank? ? %({"message":"Something went wrong"}) : response.body
        # raise RequestException.from_json(body)
      end
    end
  end
end

require "../spec_helper.cr"

describe Mailjet::Client do
  before_each do
    configure_global_api_credentials
  end

  describe "#initialize" do
    it "accepts api credentials" do
      client = Mailjet::Client.new("my_key", "my_secret")
      client.api_key.should eq("my_key")
      client.secret_key.should eq("my_secret")
    end

    it "falls back to global credentials" do
      test_client.api_key.should eq("global_key")
      test_client.secret_key.should eq("global_secret")
    end

    it "fails without api credentials" do
      Mailjet::Config.api_key = nil
      Mailjet::Config.secret_key = nil
      expect_raises(Mailjet::MissingApiCredentialsException) do
        test_client
      end
    end
  end

  describe "#handle_api_call" do
    it "performs a get request with success" do
      body = %({"drag": "transformation"})
      WebMock.stub(:get, "https://api.mailjet.com/some/path")
        .to_return(status: 200, body: body)

      response = test_client.handle_api_call("GET", "/some/path")
      response.should eq(body)
    end

    it "performs a request with query params" do
      WebMock.stub(:get, "https://api.mailjet.com/some/path/with?Special=needs")
        .to_return(status: 200, body: "{}")

      test_client.handle_api_call("GET", "/some/path/with", query: {
        special: "needs",
      })
    end

    it "performs a not found get request" do
      expect_raises(Mailjet::ResourceNotFoundException) do
        WebMock.stub(:get, "https://api.mailjet.com/non-existant")
          .to_return(status: 404, body: "{}")

        response = test_client.handle_api_call("GET", "/non-existant")
        response.should eq("{}")
      end
    end

    it "catches any other error" do
      expect_raises(Mailjet::RequestException) do
        WebMock.stub(:get, "https://api.mailjet.com/non-existant")
          .to_return(status: 401, body: "{}")

        response = test_client.handle_api_call("GET", "/non-existant")
        response.should eq("{}")
      end
    end
  end

  describe ".with_credentials" do
    it "creates a new instance with given credentials" do
      client = Mailjet::Client.with_credentials("my_key", "my_secret")
      client.api_key.should eq("my_key")
      client.secret_key.should eq("my_secret")
    end
  end
end

private def test_client
  Mailjet::Client.new
end

private def headers_with_basic_auth
  {
    "Accept"          => "application/json",
    "Content-Type"    => "application/json",
    "Accept-Encoding" => "deflate",
    "Host"            => "api.mailjet.com",
    "Authorization"   => "Basic Z2xvYmFsX2tleTpnbG9iYWxfc2VjcmV0",
    "User-Agent"      => "mailjet-api-v3-crystal/#{Mailjet::VERSION}",
  }
end

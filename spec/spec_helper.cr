require "spec"
require "webmock"
require "../src/mailjet"

def read_fixture(file : String)
  path = "#{__DIR__}/fixtures/#{file}.json"
  if File.exists?(path)
    File.read(path)
  else
    raise Exception.new("Fixture #{file} does not exist.")
  end
end

Spec.after_each do
  # Ensure stubbed requests are not cached
  WebMock.reset

  # Reset to defaults
  Mailjet.configure do |config|
    config.api_key = "abc"
    config.api_version = Mailjet::Api::V3
    config.default_from = "a@b.c"
    config.endpoint = "https://api.mailjet.com"
    config.sandbox_mode = false
    config.secret_key = "123"
  end
end

def configure_global_api_credentials
  Mailjet.configure do |config|
    config.api_key = "global_key"
    config.secret_key = "global_secret"
  end
end

require "spec"
require "webmock"
require "../src/mailjet"

Spec.after_each do
  # Ensure stubbed requests are not cached
  WebMock.reset

  # Reset to defaults
  Mailjet.configure do |config|
    config.api_key = nil
    config.api_version = "v3"
    config.default_from = nil
    config.end_point = "https://api.mailjet.com"
    config.sandbox_mode = false
    config.secret_key = nil
  end
end

def configure_global_api_credentials
  Mailjet.configure do |config|
    config.api_key = "global_key"
    config.secret_key = "global_secret"
  end
end

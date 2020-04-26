require "spec"
require "webmock"
require "../src/mailjet"

Spec.after_each do
  # Ensure stubbed requests are not cached
  WebMock.reset

  # Reset to defaults
  Mailjet::Config.api_key = nil
  Mailjet::Config.api_version = "v3"
  Mailjet::Config.default_from = nil
  Mailjet::Config.end_point = "https://api.mailjet.com"
  Mailjet::Config.sandbox_mode = false
  Mailjet::Config.secret_key = nil
end

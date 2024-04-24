require "json"
require "json_mapping"
require "big"
require "big/json"
require "http/client"
require "./mailjet/alias"
require "./mailjet/resource"
require "./mailjet/json/**"
require "./mailjet/**"

struct Mailjet
  def self.configure(&)
    yield(Mailjet::Config)
  end
end

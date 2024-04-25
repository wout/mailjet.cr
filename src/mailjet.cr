require "json"
require "json_mapping"
require "big"
require "big/json"
require "http/client"
require "habitat"
require "./mailjet/alias"
require "./mailjet/resource"
require "./mailjet/json/**"
require "./mailjet/**"

struct Mailjet
  enum Api
    V3
    V3_1

    def to_s
      case self
      in V3   then "v3"
      in V3_1 then "v3.1"
      end
    end
  end

  Habitat.create do
    setting api_key : String
    setting api_version : Api = Api::V3
    setting default_from : String, validation: :validate_default_from
    setting endpoint : String = "https://api.mailjet.com"
    setting open_timeout : Time::Span = 60.seconds
    setting read_timeout : Time::Span = 60.seconds
    setting secret_key : String
    setting sandbox_mode : Bool = false
  end

  def self.validate_default_from(email : String)
    email.match(/.+\@.+\..+/) ||
      Habitat.raise_validation_error("default_from must be a valid email address")
  end
end

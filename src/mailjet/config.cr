struct Mailjet
  module Config
    class_property api_key : String? = nil
    class_property api_version : String = "v3"
    class_property default_from : String? = nil
    class_property end_point : String = "https://api.mailjet.com"
    class_property sandbox_mode : Bool = false
    class_property secret_key : String? = nil

    def self.default_from=(email : String)
      raise InvalidEmailAddressException.new unless email.match(/.+\@.+\..+/)
      @@default_from = email
    end
  end
end

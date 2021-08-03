struct Mailjet
  struct Sender
    # Validate a registered sender email address or domain. A sender domain
    # (*@domain.com) is validated by checking the caller's rights, the existence
    # of a metasender for that domain or by searching for the ownership token on
    # the domain root or in the DNS.
    #
    # https://dev.mailjet.com/email/reference/sender-addresses-and-domains/sender#v3_post_sender_sender_ID_validate
    #
    struct Validate < Resource
      # :nodoc:
      can_create("REST/sender/:sender_id/validate", {
        "ValidationMethod": String,
        "Errors":           Hash(String, String),
        "GlobalError":      String,
      })

      # Check if sender is validated
      #
      # ```
      # validation = Mailjet::Sender::Validate.create(12345)
      # puts validation.validation_method
      # # => "ActivationEmail"
      # ```
      #
      # Note: If the user is already activated, a http status 400 will be
      # returned, which will result in a `Mailjet::RequestException` to be
      # raised.
      #
      def self.create(
        sender_id : ResourceId,
        client : Client = Client.new
      )
        create({} of String => String, {sender_id: sender_id}, client)
      end
    end
  end
end

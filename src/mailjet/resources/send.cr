struct Mailjet
  # Send API v3 and v3.1 are part of Mailjet's transactional messaging suite.
  # Send API v3.1 gives more detailed feedback information on your sendings,
  # while Send API v3 gives you a higher sending limit per single API call.
  #
  # https://dev.mailjet.com/email/reference/send-emails/
  #
  struct Send < Resource
    # Explicitly using version 3.1 of the send api
    can_create("v3.1/send", {
      "Messages": Array(ResponseMessage),
    })

    # Deliver an array of messages
    #
    # ```crystal
    # Mailjet::Send.messages([
    #   {...},
    #   {...},
    # ])
    # ```
    #
    def self.messages(
      messages : Array(Hash) | Array(NamedTuple),
      client : Client = Client.new
    )
      create({"Messages" => messages}, client: client)
    end

    struct ResponseMessage
      include Json::Fields

      json_fields({
        "Bcc":      Array(DeliveryReceipt)?,
        "Cc":       Array(DeliveryReceipt)?,
        "CustomID": String?,
        "Errors":   Array(DeliveryError)?,
        "Status":   String,
        "To":       Array(DeliveryReceipt)?,
      })
    end

    struct DeliveryReceipt
      include Json::Fields

      json_fields({
        "Email":       String,
        "MessageHref": String,
        "MessageID":   Int64,
        "MessageUUID": String,
      })
    end

    struct DeliveryError
      include Json::Fields

      json_fields({
        "ErrorCode":       String,
        "ErrorIdentifier": String,
        "ErrorMessage":    String,
        "ErrorRelatedTo":  Array(String),
        "StatusCode":      Int32,
      })
    end
  end
end

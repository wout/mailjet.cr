struct Mailjet
  # Send API v3 and v3.1 are part of Mailjet's transactional messaging suite.
  # Send API v3.1 (`Mailjet::SendV3_1`) gives more detailed feedback information
  # on your sendings, while Send API v3 (`Mailjet::SendV3`) gives you a higher
  # sending limit per single API call.
  #
  # https://dev.mailjet.com/email/reference/send-emails/
  #
  abstract struct Send < Resource
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

    struct SentMessage
      include Json::Fields

      json_fields({
        "Email":       String,
        "MessageID":   Int64,
        "MessageUUID": String,
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

  struct SendV3 < Send
    # :nodoc:
    can_create("send", {"Sent": Array(SentMessage)})

    # Deliver an array of messages
    #
    # ```
    # messages = [
    #   {...},
    #   {...},
    # ]
    # Mailjet::SendV3.messages(messages)
    # ```
    #
    def self.messages(
      messages : Array(Hash) | Array(NamedTuple),
      client : Client = Client.new
    )
      create(
        {"Messages": messages},
        params: {version: "v3"},
        client: client
      ).sent
    end
  end

  struct SendV3_1 < Send
    # :nodoc:
    can_create("send", {"Messages": Array(ResponseMessage)})

    # Deliver an array of messages
    #
    # ```
    # messages = [
    #   {...},
    #   {...},
    # ]
    # Mailjet::SendV3_1.messages(messages)
    # ```
    #
    def self.messages(
      messages : Array(Hash) | Array(NamedTuple),
      client : Client = Client.new
    )
      create(
        {"Messages": messages},
        params: {version: "v3.1"},
        client: client
      ).messages
    end
  end
end

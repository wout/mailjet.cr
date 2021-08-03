struct Mailjet
  # Send API v3 and v3.1 are part of Mailjet's transactional messaging suite.
  # Send API v3.1 gives more detailed feedback information on your sendings,
  # while Send API v3 gives you a higher sending limit per single API call.
  #
  # https://dev.mailjet.com/email/reference/send-emails/
  #
  struct Send < Resource
    # :nodoc:
    can_create("send", {
      "Messages": Array(ResponseMessage)?,
      "Sent":     Array(SentMessage)?,
    })

    # Deliver an array of messages
    #
    # ```
    # messages = [
    #   {...},
    #   {...},
    # ]
    # Mailjet::Send.messages(messages)
    # ```
    #
    # By default, the v3.1 send api is used, because it is more elegant and
    # informative. If you need to use the v3 api instead, simply pass in the
    # version number as the second parameter:
    #
    # ```
    # Mailjet::Send.messages(messages, "v3")
    # ```
    #
    def self.messages(
      messages : Array(Hash) | Array(NamedTuple),
      version : String = "v3.1",
      client : Client = Client.new
    )
      response = create({"Messages": messages},
        params: {version: version},
        client: client)

      case version
      when "v3"
        response.sent.as(Array(SentMessage))
      else
        response.messages.as(Array(ResponseMessage))
      end
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
end

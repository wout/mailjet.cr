struct Mailjet
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

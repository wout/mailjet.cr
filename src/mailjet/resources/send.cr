struct Mailjet
  struct Send < Resource
    # Explicitly using version 3.1 of the send api
    can_create("v3.1/send", {
      messages: {key: "Messages", type: Array(ResponseMessage)},
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
      JSON.mapping({
        bcc:       {key: "Bcc", type: Array(DeliveryReceipt)?},
        cc:        {key: "Cc", type: Array(DeliveryReceipt)?},
        custom_id: {key: "CustomID", type: String?},
        errors:    {key: "Errors", type: Array(DeliveryError)?},
        status:    {key: "Status", type: String},
        to:        {key: "To", type: Array(DeliveryReceipt)?},
      })
    end

    struct DeliveryReceipt
      JSON.mapping({
        email: {key: "Email", type: String},
        href:  {key: "MessageHref", type: String},
        id:    {key: "MessageID", type: BigInt},
        uuid:  {key: "MessageUUID", type: String},
      })
    end

    struct DeliveryError
      JSON.mapping({
        error_code:  {key: "ErrorCode", type: String},
        identifier:  {key: "ErrorIdentifier", type: String},
        message:     {key: "ErrorMessage", type: String},
        related_to:  {key: "ErrorRelatedTo", type: Array(String)},
        status_code: {key: "StatusCode", type: Int32},
      })
    end
  end
end

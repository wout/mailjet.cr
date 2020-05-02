struct Mailjet
  struct Message < Resource
    # Fetches all messages
    #
    # ```crystal
    # messages = Mailjet::Message.all
    # ```
    #
    # Optionally with query params
    #
    # ```crystal
    # messages = Mailjet::Message.all({contact_alt: "some@one.com"})
    # ```
    #
    can_list("REST/message", {
      "Count": Int32,
      "Data":  Array(Details),
      "Total": Int32,
    })

    # :nodoc:
    can_find("REST/message/:message_id", {
      "Data": Array(Details),
    })

    # Fetches a message for the given id
    #
    # ```crystal
    # message = Mailjet::Message.find(123456789)
    # ```
    #
    def self.find(
      message_id : Int64 | String,
      query : Hash | NamedTuple = Hash(String, String).new,
      client : Client = Client.new
    )
      find({message_id: message_id}, query: query, client: client)
    end

    struct Details
      include Json::Fields

      json_fields({
        "ArrivedAt":          Time,
        "AttachmentCount":    Int32,
        "AttemptCount":       Int32,
        "IsClickTracked":     Bool,
        "ContactAlt":         String,
        "ContactID":          Int32,
        "Delay":              Int32,
        "DestinationID":      Int32,
        "FilterTime":         Int32,
        "IsHTMLPartIncluded": Bool,
        "ID":                 Int64,
        "MessageSize":        Int32,
        "IsOpenTracked":      Bool,
        "SenderID":           Int32,
        "SpamassRules":       String,
        "SpamassassinScore":  Int32,
        "StatePermanent":     Bool,
        "Status":             String,
        "Subject":            String,
        "IsTextPartIncluded": Bool,
        "IsUnsubTracked":     Bool,
        "UUID":               String,
      })
    end
  end
end

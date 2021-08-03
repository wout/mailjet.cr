struct Mailjet
  # Every time you send an email via Mailjet, a new message object is created.
  # The resources below help you retrieve details about these messages - sending
  # time, delivery and contact engagement info, recipients, message size, etc.
  #
  # https://dev.mailjet.com/email/reference/messages/
  #
  struct Message < Resource
    alias ResponseData = Array(Details)

    # Fetch all messages
    #
    # ```
    # messages = Mailjet::Message.all
    # ```
    #
    # Optionally with query params
    #
    # ```
    # messages = Mailjet::Message.all({contact_alt: "some@one.com"})
    # ```
    #
    can_list("REST/message", ResponseData)

    # Fetch a message for the given id
    #
    # ```
    # message = Mailjet::Message.find(123456789)
    # ```
    #
    can_find("REST/message/:id", ResponseData)

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

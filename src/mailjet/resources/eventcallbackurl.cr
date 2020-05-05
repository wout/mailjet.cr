struct Mailjet
  # The resources below helps you track email delivery and engagement events and
  # forward the information to a webhook URL of your choice. You can use this
  # data to create additional workflows - react to spam reports, identify
  # bounced email addresses, sync unsubscribed contacts, etc.
  #
  # https://dev.mailjet.com/email/reference/webhook/
  #
  struct Eventcallbackurl < Resource
    alias ResponseData = Array(Webhook)

    # Find all eventcallbackurls
    #
    # ```crystal
    # response = Mailjet::Eventcallbackurl.all
    # eventcallbackurls = response.data
    # ```
    #
    can_list("REST/eventcallbackurl", ResponseData)

    # Find a eventcallbackurl
    #
    # ```crystal
    # eventcallbackurl = Mailjet::Eventcallbackurl.find(112334)
    # ```
    #
    can_find("REST/eventcallbackurl/:id", ResponseData)

    # Create a eventcallbackurl
    #
    # ```crystal
    # eventcallbackurl = Mailjet::Eventcallbackurl.create({
    #   event_type: "open",
    #   is_backup:  false,
    #   status:     "alive",
    #   version:    1,
    #   url:        "https://somesite.com/123/",
    # })
    # ```
    #
    can_create("REST/eventcallbackurl", ResponseData)

    # Update a eventcallbackurl
    #
    # ```crystal
    # eventcallbackurl = Mailjet::Eventcallbackurl.update(112334, {
    #   event_type: "open",
    #   is_backup:  false,
    #   status:     "alive",
    #   version:    1,
    #   url:        "https://somesite.com/123/",
    # })
    # ```
    #
    can_update("REST/eventcallbackurl/:id", ResponseData)

    # Delete a eventcallbackurl
    #
    # ```crystal
    # Mailjet::Eventcallbackurl.delete(112334)
    # ```
    #
    can_delete("REST/eventcallbackurl/:id")

    struct Webhook
      include Json::Fields

      json_fields({
        "APIKeyID":  Int32,
        "EventType": String,
        "ID":        Int32,
        "IsBackup":  Bool,
        "Status":    String,
        "Url":       String,
        "Version":   Int32,
      })
    end
  end
end

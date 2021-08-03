struct Mailjet
  # Senders objects are used to select the From email address for the emails
  # you are sending. Use the resources below to manage and validate your senders.
  #
  # https://dev.mailjet.com/email/reference/sender-addresses-and-domains/sender/
  #
  struct Sender < Resource
    alias ResponseData = Array(Address)

    # Find all senders
    #
    # ```
    # response = Mailjet::Sender.all
    # senders = response.data
    # addresses = response.map(&.email)
    # ```
    #
    can_list("REST/sender", ResponseData)

    # Find a sender
    #
    # ```
    # sender = Mailjet::Sender.find(1324)
    # ```
    #
    can_find("REST/sender/:id", ResponseData)

    # Create a sender
    #
    # ```
    # sender = Mailjet::Sender.create({
    #   email_type:        "transactional",
    #   is_default_sender: true,
    #   name:              "Sender1",
    #   email:             "user@example.com",
    # })
    # ```
    #
    can_create("REST/sender", ResponseData)

    # Update a sender
    #
    # ```
    # sender = Mailjet::Sender.update(1324, {
    #   email_type:        "transactional",
    #   is_default_sender: true,
    #   name:              "Sender1",
    #   email:             "user@example.com",
    # })
    # ```
    #
    can_update("REST/sender/:id", ResponseData)

    # Delete a sender
    #
    # ```
    # Mailjet::Sender.delete(1324)
    # ```
    #
    can_delete("REST/sender/:id")

    struct Address
      include Json::Fields

      json_fields({
        "CreatedAt":       Time,
        "DNSID":           Int64,
        "Email":           String,
        "EmailType":       String,
        "Filename":        String,
        "ID":              Int32,
        "IsDefaultSender": Bool,
        "Name":            String,
        "Status":          String,
      })
    end
  end
end

struct Mailjet
  struct Listrecipient < Resource
    alias ResponseData = Array(Join)

    # Find all contact lists
    #
    # ```crystal
    # response = Mailjet::Listrecipient.all
    # listrecipients = response.data
    # # or
    # response.each do |listrecipient|
    #   listrecipient.list_name
    # end
    # ```
    #
    can_list("REST/listrecipient", ResponseData)

    # Find a listrecipient
    #
    # ```crystal
    # listrecipient = Mailjet::Listrecipient.find(12345)
    # ```
    #
    can_find("REST/listrecipient/:id", ResponseData)

    # Create a listrecipient
    #
    # ```crystal
    # listrecipient = Mailjet::Listrecipient.create({
    #   is_unsubscribed: false,
    #   contact_alt:     "some@one.com",
    #   list_id:         12345,
    # })
    # ```
    #
    can_create("REST/listrecipient", ResponseData)

    # Update a listrecipient
    #
    # ```crystal
    # listrecipient = Mailjet::Listrecipient.update(12345, {
    #   is_unsubscribed: true,
    # })
    # ```
    #
    can_update("REST/listrecipient/:id", ResponseData)

    # Delete a listrecipient
    #
    # ```crystal
    # Mailjet::Listrecipient.delete(12345)
    # ```
    #
    can_delete("REST/listrecipient/:id")

    struct Join
      include Json::Fields

      json_fields({
        "ContactID":      Int32,
        "ID":             Int32,
        "IsActive":       Bool,
        "IsUnsubscribed": Bool,
        "ListID":         Int32,
        "ListName":       String,
        "SubscribedAt":   Time?,
        "UnsubscribedAt": Time?,
      })
    end
  end
end

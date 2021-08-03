struct Mailjet
  # A list recipient object manages the relationship between a contact and a
  # contactslist - every instance of a contact being added to a list creates a
  # new list recipient. Both the contact and the list need to be created
  # beforehand.
  #
  # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_get_listrecipient
  # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_get_listrecipient_listrecipient_ID
  # https://dev.mailjet.com/email/reference/contacts/subscriptions/#v3_post_listrecipient
  # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_put_listrecipient_listrecipient_ID
  # https://dev.mailjet.com/email/reference/contacts/subscriptions#v3_delete_listrecipient_listrecipient_ID
  #
  struct Listrecipient < Resource
    alias ResponseData = Array(Join)

    # Find all contact lists
    #
    # ```
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
    # ```
    # listrecipient = Mailjet::Listrecipient.find(12345)
    # ```
    #
    can_find("REST/listrecipient/:id", ResponseData)

    # Create a listrecipient
    #
    # ```
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
    # ```
    # listrecipient = Mailjet::Listrecipient.update(12345, {
    #   is_unsubscribed: true,
    # })
    # ```
    #
    can_update("REST/listrecipient/:id", ResponseData)

    # Delete a listrecipient
    #
    # ```
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

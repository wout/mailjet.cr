struct Mailjet
  # Contact List objects help you organize your contacts into lists. Every time
  # you send a campaign you must select a recipient contact list. Segmentation
  # can help you target a portion of that list.
  #
  # https://dev.mailjet.com/email/reference/contacts/contact-list/
  #
  struct Contactlist < Resource
    alias ResponseData = Array(Details)

    # Find all contact lists
    #
    # ```crystal
    # response = Mailjet::Contactlist.all
    # contactlists = response.data
    # email_addresses = response.map(&.email)
    # ```
    #
    can_list("REST/contactlist", ResponseData)

    # Find a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.find(123456789)
    # ```
    #
    can_find("REST/contactlist/:id", ResponseData)

    # Create a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.create({
    #   name: "New name",
    # })
    # ```
    #
    can_create("REST/contactlist", ResponseData)

    # Update a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.update(123456789, {
    #   name: "New name",
    # })
    # ```
    #
    can_update("REST/contactlist/:id", ResponseData)

    # Delete a contactlist
    #
    # ```crystal
    # Mailjet::Contactlist.delete(123456789)
    # ```
    #
    can_delete("REST/contactlist/:id")

    struct Details
      include Json::Fields

      json_fields({
        "Address":         String,
        "CreatedAt":       Time,
        "ID":              Int32,
        "IsDeleted":       Bool,
        "Name":            String,
        "SubscriberCount": Int32,
      })
    end
  end
end

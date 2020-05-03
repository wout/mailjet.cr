struct Mailjet
  struct Contactlist < Resource
    # Create a contactlist
    #
    # ```crystal
    # response = Mailjet::Contactlist.all
    # contactlists = response.data
    # email_addresses = response.map(&.email)
    # ```
    #
    can_list("REST/contactlist", {
      "Count": Int32,
      "Data":  Array(Details),
      "Total": Int32,
    })

    # Find a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.find(123456789)
    # ```
    #
    can_find("REST/contactlist/:id", {
      "Data": Array(Details),
    })

    # Create a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.create({
    # })
    # ```
    #
    can_create("REST/contactlist", {
      "Data": Array(Details),
    })

    # Update a contactlist
    #
    # ```crystal
    # contactlist = Mailjet::Contactlist.update(123456789, {
    # })
    # ```
    #
    can_update("REST/contactlist/:id", {
      "Data": Array(Details),
    })

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

struct Mailjet
  struct Contact < Resource
    # Create a contact
    #
    # ```crystal
    # response = Mailjet::Contact.all
    # contacts = response.data
    # email_addresses = response.map(&.email)
    # ```
    #
    can_list("REST/contact", {
      "Count": Int32,
      "Data":  Array(Details),
      "Total": Int32,
    })

    # Find a contact
    #
    # ```crystal
    # contact = Mailjet::Contact.find(123456789)
    # ```
    #
    can_find("REST/contact/:id", {
      "Data": Array(Details),
    })

    # Create a contact
    #
    # ```crystal
    # contact = Mailjet::Contact.create({
    #   name:                       "Contact name",
    #   email:                      "contact@email.com",
    #   is_excluded_from_campaigns: false,
    # })
    # ```
    #
    can_create("REST/contact", {
      "Data": Array(Details),
    })

    # Update a contact
    #
    # ```crystal
    # contact = Mailjet::Contact.update(123456789, {
    #   name:                       "Another name",
    #   is_excluded_from_campaigns: true,
    # })
    # ```
    #
    can_update("REST/contact/:id", {
      "Data": Array(Details),
    })

    struct Details
      include Json::Fields

      json_fields({
        "CreatedAt":                       String,
        "DeliveredCount":                  Int32,
        "Email":                           String,
        "ExclusionFromCampaignsUpdatedAt": Time?,
        "ID":                              Int32,
        "IsExcludedFromCampaigns":         Bool,
        "IsOptInPending":                  Bool,
        "IsSpamComplaining":               Bool,
        "LastActivityAt":                  Time?,
        "LastUpdateAt":                    Time?,
        "Name":                            String,
        "UnsubscribedAt":                  Time?,
        "UnsubscribedBy":                  Time?,
      })
    end
  end
end

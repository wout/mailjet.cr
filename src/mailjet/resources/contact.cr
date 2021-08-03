struct Mailjet
  # Contact objects represent the email addresses you intend to send (or have
  # already sent) messages to.
  #
  # https://dev.mailjet.com/email/reference/contacts/contact/
  #
  struct Contact < Resource
    alias ResponseData = Array(Details)

    # Create a contact
    #
    # ```
    # response = Mailjet::Contact.all
    # contacts = response.data
    # email_addresses = response.map(&.email)
    # ```
    #
    can_list("REST/contact", ResponseData)

    # Find a contact
    #
    # ```
    # contact = Mailjet::Contact.find(123456789)
    # ```
    #
    can_find("REST/contact/:id", ResponseData)

    # Create a contact
    #
    # ```
    # contact = Mailjet::Contact.create({
    #   name:                       "Contact name",
    #   email:                      "contact@email.com",
    #   is_excluded_from_campaigns: false,
    # })
    # ```
    #
    can_create("REST/contact", ResponseData)

    # Update a contact
    #
    # ```
    # contact = Mailjet::Contact.update(123456789, {
    #   name:                       "Another name",
    #   is_excluded_from_campaigns: true,
    # })
    # ```
    #
    can_update("REST/contact/:id", ResponseData)

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

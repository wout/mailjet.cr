struct Mailjet
  # To send a marketing campaign, you first need to create a draft object. In
  # that object you specify the senders, recipients, contents, etc. Use the
  # resources below to manage your drafts, as well as test, schedule and send
  # them. Once a draft is sent, it automatically creates a campaign object.
  #
  # https://dev.mailjet.com/email/reference/campaigns/drafts/
  #
  struct Campaigndraft < Resource
    alias ResponseData = Array(Draft)

    # Find all contact lists
    #
    # ```
    # response = Mailjet::Campaigndraft.all
    # campaigndrafts = response.data
    # ```
    #
    can_list("REST/campaigndraft", ResponseData)

    # Find a campaigndraft
    #
    # ```
    # campaigndraft = Mailjet::Campaigndraft.find(112334)
    # ```
    #
    can_find("REST/campaigndraft/:id", ResponseData)

    # Create a campaigndraft
    #
    # ```
    # campaigndraft = Mailjet::Campaigndraft.create({
    #   locale:  "en_US",
    #   subject: "It's going to be fabulous!",
    # })
    # ```
    #
    can_create("REST/campaigndraft", ResponseData)

    # Update a campaigndraft
    #
    # ```
    # campaigndraft = Mailjet::Campaigndraft.update(112334, {
    #   subject: "It's going to be gorgeous!",
    # })
    # ```
    #
    can_update("REST/campaigndraft/:id", ResponseData)

    struct Draft
      include Json::Fields

      json_fields({
        "AXFraction":         Int32,
        "AXFractionName":     String,
        "ContactsListID":     Int32?,
        "CreatedAt":          Time,
        "Current":            Int32,
        "DeliveredAt":        Time?,
        "EditMode":           String,
        "ID":                 Int32,
        "IsStarred":          Bool,
        "IsTextPartIncluded": Bool,
        "Locale":             String,
        "ModifiedAt":         Time?,
        "Preset":             JSON::Any,
        "Sender":             String,
        "SenderEmail":        String,
        "SenderName":         String,
        "Status":             Int32,
        "Subject":            String,
        "TemplateID":         Int32?,
        "Title":              String,
        "Url":                String,
        "Used":               Bool,
      })
    end
  end
end

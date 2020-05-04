struct Mailjet
  # Segmentation is an extremely useful tool used to target a specific group of
  # customers with a dedicated campaign. Create segments based on contact
  # properties or the contact activity (opens, clicks). Segmentation helps you
  # focus your campaigns on specific demographics, create re-engagement
  # campaigns, etc.
  #
  # https://dev.mailjet.com/email/reference/segmentation/
  #
  struct Contactfilter < Resource
    alias ResponseData = Array(Filter)

    # Find all contactfilters
    #
    # ```crystal
    # response = Mailjet::Contactfilter.all
    # contactfilters = response.data
    # ```
    #
    can_list("REST/contactfilter", ResponseData)

    # Find a contactfilter
    #
    # ```crystal
    # contactfilter = Mailjet::Contactfilter.find(112334)
    # ```
    #
    can_find("REST/contactfilter/:id", ResponseData)

    # Create a contactfilter
    #
    # ```crystal
    # contactfilter = Mailjet::Contactfilter.create({
    #   description: "Users that have not clicked on an email link in the last 14 days",
    #   expression:  "((not hasclickedsince(14)))",
    #   name:        "Inactive customers",
    # })
    # ```
    #
    can_create("REST/contactfilter", ResponseData)

    # Update a contactfilter
    #
    # ```crystal
    # contactfilter = Mailjet::Contactfilter.update(112334, {
    #   description: "Users that have not clicked on an email link in the last 7 days",
    #   expression:  "((not hasclickedsince(7)))",
    #   name:        "Inactive customers",
    # })
    # ```
    #
    can_update("REST/contactfilter/:id", ResponseData)

    # Delete a contactfilter
    #
    # ```crystal
    # Mailjet::Contactfilter.delete(112334)
    # ```
    #
    can_delete("REST/contactfilter/:id")

    struct Filter
      include Json::Fields

      json_fields({
        "Description": String,
        "Expression":  String,
        "ID":          Int32,
        "Name":        String,
        "Status":      String,
      })
    end
  end
end

struct Mailjet
  # Templates are essential building blocks for your campaigns, transactional
  # emails or automation workflows. With the resources below you can manage your
  # templates and their content.
  #
  # https://dev.mailjet.com/email/reference/templates/
  #
  struct Template < Resource
    alias ResponseData = Array(Details)

    # Find all contact lists
    #
    # ```
    # response = Mailjet::Template.all
    # templates = response.data
    # ```
    #
    can_list("REST/template", ResponseData)

    # Find a template
    #
    # ```
    # template = Mailjet::Template.find(123456789)
    # ```
    #
    can_find("REST/template/:id", ResponseData)

    # Create a template
    #
    # ```
    # template = Mailjet::Template.create({
    #   author:     "John Doe",
    #   categories: [
    #     "commerce",
    #   ],
    #   copyright:   "John Doe",
    #   description: "Used for discount promotion.",
    #   ...
    # })
    # ```
    #
    can_create("REST/template", ResponseData)

    # Update a template
    #
    # ```
    # template = Mailjet::Template.update(123456789, {
    #   author:     "John Doe",
    #   categories: [
    #     "commerce",
    #   ],
    #   copyright:   "John Doe",
    #   description: "Used for discount promotion.",
    #   ...
    # })
    # ```
    #
    can_update("REST/template/:id", ResponseData)

    # Delete a template
    #
    # ```
    # Mailjet::Template.delete(123456789)
    # ```
    #
    can_delete("REST/template/:id")

    struct Details
      include Json::Fields

      json_fields({
        "ID":                          Int32,
        "Name":                        String,
        "Author":                      String,
        "OwnerId":                     Int32,
        "OwnerType":                   String,
        "Presets":                     JSON::Any,
        "Categories":                  Array(String),
        "Copyright":                   String,
        "Description":                 String,
        "EditMode":                    Int32,
        "IsStarred":                   Bool,
        "IsTextPartGenerationEnabled": Bool,
        "Locale":                      String,
        "LocaleList":                  Array(String)?,
        "Previews":                    Array(Int32),
        "Purposes":                    Array(String),
        "CreatedAt":                   Time,
        "LastUpdatedAt":               Time,
      })
    end
  end
end

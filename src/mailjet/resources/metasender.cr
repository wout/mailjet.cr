struct Mailjet
  # Metasender objects are senders, which can be used on the master account as
  # well as all sub-account API Keys. Use the resources below to manage your
  # metasenders.
  #
  # https://dev.mailjet.com/email/reference/sender-addresses-and-domains/metasender/
  #
  struct Metasender < Resource
    alias ResponseData = Array(Details)

    # Find all metasenders
    #
    # ```crystal
    # response = Mailjet::Metasender.all
    # metasenders = response.data
    # ```
    #
    can_list("REST/metasender", ResponseData)

    # Find a metasender
    #
    # ```crystal
    # metasender = Mailjet::Metasender.find(112334)
    # ```
    #
    can_find("REST/metasender/:id", ResponseData)

    # Create a metasender
    #
    # ```crystal
    # metasender = Mailjet::Metasender.create({
    #   description: "Metasender 2 - used for Promo emails",
    #   email:       "info@some.one",
    # })
    # ```
    #
    can_create("REST/metasender", ResponseData)

    # Update a metasender
    #
    # ```crystal
    # metasender = Mailjet::Metasender.update(112334, {
    #   email: "info@someone.com",
    # })
    # ```
    #
    can_update("REST/metasender/:id", ResponseData)

    struct Details
      include Json::Fields

      json_fields({
        "CreatedAt":   Time,
        "Description": String,
        "Email":       String,
        "Filename":    String,
        "ID":          Int32,
        "IsEnabled":   Bool,
      })
    end
  end
end

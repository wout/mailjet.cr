struct Mailjet
  # Whenever you register a new sender or metasender address with a new domain
  # name, a new DNS object is created for this domain. Use the resources below
  # to retrieve the DNS records you need to complete a successful domain
  # validation and SPF / DKIM authentication.
  #
  # https://dev.mailjet.com/email/reference/sender-addresses-and-domains/dns/
  #
  struct DNS < Resource
    alias ResponseData = Array(Settings)

    # Find all dns settings
    #
    # ```crystal
    # response = Mailjet::Contactfilter.all
    # settings = response.data
    # ```
    #
    can_list("REST/dns", ResponseData)

    # Find dns settings for one record
    #
    # ```crystal
    # settings = Mailjet::Contactfilter.find(112334)
    # ```
    #
    can_find("REST/dns/:id", ResponseData)

    struct Settings
      include Json::Fields

      json_fields({
        "DKIMRecordName":           String,
        "DKIMRecordValue":          String,
        "DKIMStatus":               String,
        "Domain":                   String,
        "ID":                       Int64,
        "IsCheckInProgress":        Bool,
        "LastCheckAt":              Time?,
        "OwnerShipToken":           String,
        "OwnerShipTokenRecordName": String,
        "SPFRecordValue":           String,
        "SPFStatus":                String,
      })
    end
  end
end

struct Mailjet
  struct Contact < Resource
    can_create("REST/contact", {
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

struct Mailjet
  # When you send a campaign draft, a new campaign object is automatically
  # created. Use the resources below to retrieve information about campaigns,
  # mark selected campaigns as starred or delete them.
  #
  # https://dev.mailjet.com/email/reference/campaigns/sent-campaigns/
  #
  struct Campaign < Resource
    alias ResponseData = Array(Details)

    # Find all campaigns
    #
    # ```crystal
    # response = Mailjet::Campaign.all
    # campaigns = response.data
    # ```
    #
    can_list("REST/campaign", ResponseData)

    # Find a campaign
    #
    # ```crystal
    # campaign = Mailjet::Campaign.find(1234567890987654400)
    # ```
    #
    can_find("REST/campaign/:id", ResponseData)

    # Update a campaign
    #
    # ```crystal
    # campaign = Mailjet::Campaign.update(1234567890987654400, {
    #   is_deleted: true,
    #   is_starred: false,
    # })
    # ```
    #
    can_update("REST/campaign/:id", ResponseData)

    struct Details
      include Json::Fields

      json_fields({
        "IsDeleted":               Bool,
        "IsStarred":               Bool,
        "CampaignType":            Int32,
        "ClickTracked":            Int32,
        "CreatedAt":               Time,
        "CustomValue":             String,
        "FirstMessageID":          Int64,
        "FromEmail":               String,
        "FromID":                  Int32,
        "FromName":                String,
        "HasHtmlCount":            Int32,
        "HasTxtCount":             Int32,
        "ID":                      Int64,
        "ListID":                  Int32,
        "NewsLetterID":            Int32,
        "OpenTracked":             Int32,
        "SegmentationID":          Int32,
        "SendEndAt":               Time,
        "SendStartAt":             Time,
        "SpamassScore":            String,
        "Status":                  Int32,
        "Subject":                 String,
        "UnsubscribeTrackedCount": Int32,
        "WorkflowID":              Int32,
      })
    end
  end
end

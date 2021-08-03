struct Mailjet
  # Retrieve sending / size / spam information about all messages.
  #
  # https://dev.mailjet.com/email/reference/messages#v3_get_messageinformation
  # https://dev.mailjet.com/email/reference/messages/#v3_get_messageinformation_message_ID
  #
  struct Messageinformation < Resource
    alias ResponseData = Array(Info)

    # Fetches the history of all messages between two dates
    #
    # ```
    # information = Mailjet::Messageinformation.all({
    #   from_ts: Time.local.at_beginning_of_week.to_rfc3339,
    #   to_ts:   Time.local.to_rfc3339,
    # })
    # information.data.first.spam_assassin_score
    # => 0
    # ```
    #
    can_list("REST/messageinformation", ResponseData)

    # Fetches the history for a given message id
    #
    # ```
    # information = Mailjet::Messageinformation.find(576460754655154659)
    # information.data.first.spam_assassin_score
    # => 0
    # ```
    #
    can_find("REST/messageinformation/:id", ResponseData)

    struct Info
      include Json::Fields

      json_fields({
        "CampaignID":        Int32,
        "ClickTrackedCount": Int32,
        "ContactID":         Int32,
        "CreatedAt":         Time,
        "ID":                Int64,
        "MessageSize":       Int32,
        "OpenTrackedCount":  Int32,
        "QueuedCount":       Int32,
        "SendEndAt":         Time,
        "SentCount":         Int32,
        "SpamAssassinRules": Hash(String, String | Int32),
        "SpamAssassinScore": Int32,
      })
    end
  end
end

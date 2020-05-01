struct Mailjet
  struct Message < Resource
    # Fetches all messages
    #
    # ```crystal
    # messages = Mailjet::Message.all
    # ```
    #
    # Optionally with query params
    #
    # ```crystal
    # messages = Mailjet::Message.all(query: {contact_alt: "some@one.com"})
    # ```
    #
    can_list("REST/message", {
      count: {key: "Count", type: Int32},
      data:  {key: "Data", type: Array(Details)},
      total: {key: "Total", type: Int32},
    })

    # :nodoc:
    can_find("REST/message/:message_id", {
      data: {key: "Data", type: Array(Details)},
    })

    # Fetches a message for the given id
    #
    # ```crystal
    # message = Mailjet::Message.find(123456789)
    # ```
    #
    def self.find(
      message_id : Int64 | String,
      query : Hash | NamedTuple = Hash(String, String).new,
      client : Client = Client.new
    )
      find({message_id: message_id}, query: query, client: client).data.first
    end

    struct Details
      JSON.mapping({
        arrived_at:          {key: "ArrivedAt", type: Time},
        attachment_count:    {key: "AttachmentCount", type: Int32},
        attempt_count:       {key: "AttemptCount", type: Int32},
        click_tracked?:      {key: "IsClickTracked", type: Bool},
        contact_alt:         {key: "ContactAlt", type: String},
        contact_id:          {key: "ContactID", type: Int32},
        delay:               {key: "Delay", type: Int32},
        destination_id:      {key: "DestinationID", type: Int32},
        filter_time:         {key: "FilterTime", type: Int32},
        html_part_included?: {key: "IsHTMLPartIncluded", type: Bool},
        id:                  {key: "ID", type: Int64},
        message_size:        {key: "MessageSize", type: Int32},
        open_tracked?:       {key: "IsOpenTracked", type: Bool},
        sender_id:           {key: "SenderID", type: Int32},
        spamass_rules:       {key: "SpamassRules", type: String},
        spamassassin_score:  {key: "SpamassassinScore", type: Int32},
        state_permanent:     {key: "StatePermanent", type: Bool},
        status:              {key: "Status", type: String},
        subject:             {key: "Subject", type: String},
        text_part_included?: {key: "IsTextPartIncluded", type: Bool},
        unsub_tracked?:      {key: "IsUnsubTracked", type: Bool},
        uuid:                {key: "UUID", type: String},
      })
    end
  end
end

struct Mailjet
  struct Messagehistory < Resource
    # :nodoc:
    can_find("REST/messagehistory/:message_id", {
      count: {key: "Count", type: Int32},
      data:  {key: "Data", type: Array(Event)},
      total: {key: "Total", type: Int32},
    })

    # Fetches the history of a message
    #
    # ```crystal
    # messages = Mailjet::Messagehistory.find(576460754655154659)
    # ```
    #
    def self.find(
      message_id : Int64 | String,
      client : Client = Client.new
    )
      find({message_id: message_id}, client: client)
    end

    struct Event
      JSON.mapping({
        comment:      {key: "Comment", type: String},
        event_at:     {key: "EventAt", type: Int32},
        event_type:   {key: "EventType", type: String},
        state:        {key: "State", type: String},
        useragent:    {key: "Useragent", type: String},
        useragent_id: {key: "UseragentID", type: Int32},
      })
    end
  end
end

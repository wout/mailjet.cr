struct Mailjet
  struct Messagehistory < Resource
    # :nodoc:
    can_find("REST/messagehistory/:message_id", {
      "Count": Int32,
      "Data":  Array(Event),
      "Total": Int32,
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
      include Json::Fields

      json_fields({
        "Comment":     String,
        "EventAt":     {type: Time, converter: Time::EpochConverter},
        "EventType":   String,
        "State":       String,
        "Useragent":   String,
        "UseragentID": Int32,
      })
    end
  end
end

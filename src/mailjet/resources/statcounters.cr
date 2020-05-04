struct Mailjet
  # Get aggregated statistics for a specific campaign, list, API Key or sender
  # email address. Both message-based and event-based stats can be retrieved.
  #
  # https://dev.mailjet.com/email/reference/statistics#v3_get_statcounters
  #
  struct Statcounters < Resource
    alias ResponseData = Array(Counters)

    # Raw statcounter endpoint, requiring a series of parameters
    #
    # ```crystal
    # response = Mailjet::Statcounters.all({
    #   counter_source:     "apikey",
    #   counter_timing:     "message",
    #   counter_resolution: "lifetime",
    # })
    # stats = response.data.first
    # ```
    #
    can_list("REST/statcounters", ResponseData)

    # Convenience method to retrieve statistics at current API key level
    #
    # ```crystal
    # response = Mailjet::Statcounters.by_api_key({
    #   counter_timing:     "event",
    #   counter_resolution: "hour",
    #   from_ts:            Time.local.at_beginning_of_week.to_unix,
    #   to_ts:              Time.local.to_unix,
    # })
    # stats = response.data.first
    # ```
    #
    def self.by_api_key(
      query : Hash | NamedTuple,
      client : Client = Client.new
    )
      all(query: query.to_h.merge({
        :counter_source => "api_key",
      }), client: client)
    end

    # Convenience method to retrieve statistics at campaign level
    #
    # ```crystal
    # response = Mailjet::Statcounters.by_campaign(123456, {
    #   counter_timing:     "event",
    #   counter_resolution: "day",
    #   from_ts:            Time.local.at_beginning_of_day.to_unix,
    #   to_ts:              Time.local.to_unix,
    # })
    # stats = response.data.first
    # ```
    #
    def self.by_campaign(
      campaign_id : Int32 | String,
      query : Hash | NamedTuple,
      client : Client = Client.new
    )
      all(query: query.to_h.merge({
        :counter_source => "campaign",
        :source_id      => campaign_id,
      }), client: client)
    end

    # Convenience method to retrieve statistics at list level
    #
    # ```crystal
    # response = Mailjet::Statcounters.by_list(123456)
    # stats = response.data.first
    # ```
    #
    def self.by_list(
      list_id : Int32 | String,
      client : Client = Client.new
    )
      all(query: {
        :counter_timing     => "message",
        :counter_resolution => "lifetime",
        :counter_source     => "list",
        :source_id          => list_id,
      }, client: client)
    end

    # Convenience method to retrieve statistics at sender level
    #
    # ```crystal
    # response = Mailjet::Statcounters.by_sender(123456, {
    #   counter_resolution: "lifetime",
    # })
    # stats = response.data.first
    # ```
    #
    def self.by_sender(
      sender_id : Int32 | String,
      query : Hash | NamedTuple = Hash(String, String).new,
      client : Client = Client.new
    )
      all(query: query.to_h.merge({
        :counter_timing => "message",
        :counter_source => "sender",
        :source_id      => sender_id,
      }), client: client)
    end

    struct Counters
      include Json::Fields

      json_fields({
        "APIKeyID":                   Int32,
        "EventClickDelay":            Int32,
        "EventClickedCount":          Int32,
        "EventOpenDelay":             Int32,
        "EventOpenedCount":           Int32,
        "EventSpamCount":             Int32,
        "EventUnsubscribedCount":     Int32,
        "EventWorkflowExitedCount":   Int32,
        "MessageBlockedCount":        Int32,
        "MessageClickedCount":        Int32,
        "MessageDeferredCount":       Int32,
        "MessageHardBouncedCount":    Int32,
        "MessageOpenedCount":         Int32,
        "MessageQueuedCount":         Int32,
        "MessageSentCount":           Int32,
        "MessageSoftBouncedCount":    Int32,
        "MessageSpamCount":           Int32,
        "MessageUnsubscribedCount":   Int32,
        "MessageWorkFlowExitedCount": Int32,
        "SourceID":                   Int32,
        "Timeslice":                  String,
        "Total":                      Int32,
      })
    end
  end
end

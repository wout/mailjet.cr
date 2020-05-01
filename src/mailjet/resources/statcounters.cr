struct Mailjet
  struct Statcounters < Resource
    # Raw statcounter endpoint, requiring a series of parameters
    #
    # ```crystal
    # response = Mailjet::Statcounters.all(query: {
    #   counter_source:     "apikey",
    #   counter_timing:     "message",
    #   counter_resolution: "lifetime",
    # })
    # stats = response.data.first
    # ```
    #
    can_list("REST/statcounters", {
      count: {key: "Count", type: Int32},
      data:  {key: "Data", type: Array(Counters)},
      total: {key: "Total", type: Int32},
    })

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
      JSON.mapping({
        api_key_id:                     {key: "APIKeyID", type: Int32},
        event_click_delay:              {key: "EventClickDelay", type: Int32},
        event_clicked_count:            {key: "EventClickedCount", type: Int32},
        event_open_delay:               {key: "EventOpenDelay", type: Int32},
        event_opened_count:             {key: "EventOpenedCount", type: Int32},
        event_spam_count:               {key: "EventSpamCount", type: Int32},
        event_unsubscribed_count:       {key: "EventUnsubscribedCount", type: Int32},
        event_workflow_exited_count:    {key: "EventWorkflowExitedCount", type: Int32},
        message_blocked_count:          {key: "MessageBlockedCount", type: Int32},
        message_clicked_count:          {key: "MessageClickedCount", type: Int32},
        message_deferred_count:         {key: "MessageDeferredCount", type: Int32},
        message_hard_bounced_count:     {key: "MessageHardBouncedCount", type: Int32},
        message_opened_count:           {key: "MessageOpenedCount", type: Int32},
        message_queued_count:           {key: "MessageQueuedCount", type: Int32},
        message_sent_count:             {key: "MessageSentCount", type: Int32},
        message_soft_bounced_count:     {key: "MessageSoftBouncedCount", type: Int32},
        message_spam_count:             {key: "MessageSpamCount", type: Int32},
        message_unsubscribed_count:     {key: "MessageUnsubscribedCount", type: Int32},
        message_work_flow_exited_count: {key: "MessageWorkFlowExitedCount", type: Int32},
        source_id:                      {key: "SourceID", type: Int32},
        timeslice:                      {key: "Timeslice", type: String},
        total:                          {key: "Total", type: Int32},
      })
    end
  end
end

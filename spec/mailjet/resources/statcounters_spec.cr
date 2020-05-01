require "../../spec_helper.cr"

describe Mailjet::Statcounters do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches statistics for the given parameters" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/statcounters?CounterSource=apikey&CounterTiming=message&CounterResolution=lifetime")
        .to_return(status: 200, body: read_fixture("statcounters/all"))

      response = Mailjet::Statcounters.all(query: {
        counter_source:     "apikey",
        counter_timing:     "message",
        counter_resolution: "lifetime",
      })
      response.data.first.should be_a(Mailjet::Statcounters::Counters)
      response.count.should eq(1)
      response.total.should eq(1)
    end
  end

  describe ".by_api_key" do
    it "fetches statistics for the current api key" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/statcounters?CounterTiming=event&CounterResolution=hour&FromTs=1587942000&ToTs=1588340370&CounterSource=api_key")
        .to_return(status: 200, body: read_fixture("statcounters/all"))

      response = Mailjet::Statcounters.by_api_key({
        counter_timing:     "event",
        counter_resolution: "hour",
        from_ts:            1587942000,
        to_ts:              1588340370,
      })
      response.data.first.should be_a(Mailjet::Statcounters::Counters)
    end
  end

  describe ".by_campaign" do
    it "fetches statistics for the given campaign id" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/statcounters?CounterTiming=event&CounterResolution=day&FromTs=1587942000&ToTs=1588340370&CounterSource=campaign&SourceId=123456")
        .to_return(status: 200, body: read_fixture("statcounters/all"))

      response = Mailjet::Statcounters.by_campaign(123456, {
        counter_timing:     "event",
        counter_resolution: "day",
        from_ts:            1587942000,
        to_ts:              1588340370,
      })
      response.data.first.should be_a(Mailjet::Statcounters::Counters)
    end
  end

  describe ".by_list" do
    it "fetches statistics for the given list id" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/statcounters?CounterTiming=message&CounterResolution=lifetime&CounterSource=list&SourceId=123456")
        .to_return(status: 200, body: read_fixture("statcounters/all"))

      response = Mailjet::Statcounters.by_list(123456)
      response.data.first.should be_a(Mailjet::Statcounters::Counters)
    end
  end

  describe ".by_sender" do
    it "fetches statistics for the given sender id" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/statcounters?CounterResolution=lifetime&CounterTiming=message&CounterSource=sender&SourceId=123456")
        .to_return(status: 200, body: read_fixture("statcounters/all"))

      response = Mailjet::Statcounters.by_sender(123456, {
        counter_resolution: "lifetime",
      })
      response.data.first.should be_a(Mailjet::Statcounters::Counters)
    end
  end
end

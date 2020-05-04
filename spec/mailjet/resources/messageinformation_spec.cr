require "../../spec_helper.cr"

describe Mailjet::Messageinformation do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "returns an array with events for the given message id" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/messageinformation?FromTs=2020-04-27T16%3A39%3A55Z&ToTs=2020-04-29T16%3A39%3A55Z")
        .to_return(status: 200, body: read_fixture("messageinformation/all"))

      response = Mailjet::Messageinformation.all({
        from_ts: "2020-04-27T16:39:55Z",
        to_ts:   "2020-04-29T16:39:55Z",
      })
      response.data.first.should be_a(Mailjet::Messageinformation::Info)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "returns an array with events for the given message id" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/messageinformation/576460754655154658")
        .to_return(status: 200, body: read_fixture("messageinformation/find"))

      response = Mailjet::Messageinformation.find(576460754655154658)
      response.should be_a(Mailjet::Messageinformation::Info)
    end
  end
end

describe Mailjet::Messageinformation::Info do
  it "parses message history events" do
    response = Mailjet::Messageinformation::ListResponse.from_json(
      read_fixture("messageinformation/all"))
    info = response.data.first
    info.campaign_id.should eq(0)
    info.click_tracked_count.should eq(0)
    info.contact_id.should eq(50559566)
    info.created_at.should eq(Time.parse_rfc3339("2020-04-19T07:35:47Z"))
    info.id.should eq(1150221507885605625)
    info.message_size.should eq(396)
    info.open_tracked_count.should eq(153381810)
    info.queued_count.should eq(0)
    info.send_end_at.should eq(Time.parse_rfc3339("2020-04-19T07:35:47Z"))
    info.sent_count.should eq(155581793)
    info.spam_assassin_rules.should eq({"ALT" => "", "ID" => -1})
    info.spam_assassin_score.should eq(0)
  end
end

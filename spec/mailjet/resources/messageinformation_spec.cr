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

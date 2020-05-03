require "../../spec_helper.cr"

describe Mailjet::Messagehistory do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "returns an array with events for the given message id" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/messagehistory/576460754655154658")
        .to_return(status: 200, body: read_fixture("messagehistory/all"))

      response = Mailjet::Messagehistory.all(params: {id: 576460754655154658})
      response.data.first.should be_a(Mailjet::Messagehistory::Event)
      response.count.should eq(2)
      response.total.should eq(2)
    end

    it "allows the message id alone to be passed" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/messagehistory/576460754655154659")
        .to_return(status: 200, body: read_fixture("messagehistory/all"))

      events = Mailjet::Messagehistory.all(576460754655154659)
      events.should be_a(Array(Mailjet::Messagehistory::Event))
    end
  end
end

describe Mailjet::Messagehistory::Event do
  it "parses message history events" do
    response = Mailjet::Messagehistory::ListResponse.from_json(
      read_fixture("messagehistory/all"))
    message = response.data.first
    message.comment.should eq("")
    message.event_at.should eq(Time.unix(1588188885))
    message.event_type.should eq("sent")
    message.state.should eq("")
    message.useragent.should eq("")
    message.useragent_id.should eq(0)
  end
end

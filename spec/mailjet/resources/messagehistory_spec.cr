require "../../spec_helper.cr"

describe Mailjet::Messagehistory do
  before_each do
    configure_global_api_credentials
  end

  describe ".find" do
    it "returns an array with events for the given message id" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/messagehistory/576460754655154659")
        .to_return(status: 200, body: read_fixture("messagehistory/find"))

      response = Mailjet::Messagehistory.find(576460754655154659)
      response.data.first.should be_a(Mailjet::Messagehistory::Event)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end
end

describe Mailjet::Messagehistory::Event do
  it "parses message history events" do
    response = Mailjet::Messagehistory::FindResponse.from_json(
      read_fixture("messagehistory/find"))
    message = response.data.first
    message.comment.should eq("")
    message.event_at.should be_a(Time)
    message.event_type.should eq("sent")
    message.state.should eq("")
    message.useragent.should eq("")
    message.useragent_id.should eq(0)
  end
end

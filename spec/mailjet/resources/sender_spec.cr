require "../../spec_helper.cr"

describe Mailjet::Sender do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all senders" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/sender")
        .to_return(status: 200, body: read_fixture("sender/all"))

      response = Mailjet::Sender.all
      response.data.first.should be_a(Mailjet::Sender::Address)
      response.count.should eq(3)
      response.total.should eq(3)
    end
  end

  describe ".find" do
    it "fetches a single sender" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/sender/13245")
        .to_return(status: 200, body: read_fixture("sender/one"))

      response = Mailjet::Sender.find(13245)
      response.should be_a(Mailjet::Sender::Address)
    end
  end

  describe ".create" do
    it "creates a new sender" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/sender")
        .to_return(status: 200, body: read_fixture("sender/one"))

      response = Mailjet::Sender.create({
        name: "Sender 1",
      })
      response.should be_a(Mailjet::Sender::Address)
    end
  end

  describe ".update" do
    it "updates an existing sender" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/sender/13245")
        .to_return(status: 200, body: read_fixture("sender/one"))

      response = Mailjet::Sender.update(13245, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Sender::Address)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/sender/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Sender.update(13245)
      response.should be_nil
    end
  end

  describe ".delete" do
    it "deletes an existing sender" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/REST/sender/13245")
        .to_return(status: 204, body: "")

      response = Mailjet::Sender.delete(13245)
      response.should be_nil
    end
  end
end

describe Mailjet::Sender::Address do
  it "parses sender details" do
    response = Mailjet::Sender::CreateResponse.from_json(
      read_fixture("sender/one"))
    resource = response.data.first
    resource.created_at.should eq(Time.parse_rfc3339("2020-04-19T07:32:09Z"))
    resource.dnsid.should eq(4758266369)
    resource.email.should eq("some@one.com")
    resource.email_type.should eq("unknown")
    resource.filename.should eq("")
    resource.id.should eq(26888)
    resource.is_default_sender.should be_false
    resource.name.should eq("Default")
    resource.status.should eq("Active")
  end
end

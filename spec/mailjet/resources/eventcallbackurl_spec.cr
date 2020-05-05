require "../../spec_helper.cr"

describe Mailjet::Eventcallbackurl do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all eventcallbackurls" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/eventcallbackurl")
        .to_return(status: 200, body: read_fixture("eventcallbackurl/all"))

      response = Mailjet::Eventcallbackurl.all
      response.data.first.should be_a(Mailjet::Eventcallbackurl::Webhook)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single eventcallbackurl" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/eventcallbackurl/13245")
        .to_return(status: 200, body: read_fixture("eventcallbackurl/all"))

      response = Mailjet::Eventcallbackurl.find(13245)
      response.should be_a(Mailjet::Eventcallbackurl::Webhook)
    end
  end

  describe ".create" do
    it "creates a new eventcallbackurl" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/eventcallbackurl")
        .to_return(status: 200, body: read_fixture("eventcallbackurl/all"))

      response = Mailjet::Eventcallbackurl.create({
        name: "Eventcallbackurl 1",
      })
      response.should be_a(Mailjet::Eventcallbackurl::Webhook)
    end
  end

  describe ".update" do
    it "updates an existing eventcallbackurl" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/eventcallbackurl/13245")
        .to_return(status: 200, body: read_fixture("eventcallbackurl/all"))

      response = Mailjet::Eventcallbackurl.update(13245, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Eventcallbackurl::Webhook)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/eventcallbackurl/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Eventcallbackurl.update(13245)
      response.should be_nil
    end
  end

  describe ".delete" do
    it "deletes an existing eventcallbackurl" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/REST/eventcallbackurl/13245")
        .to_return(status: 204, body: "")

      response = Mailjet::Eventcallbackurl.delete(13245)
      response.should be_nil
    end
  end
end

describe Mailjet::Eventcallbackurl::Webhook do
  it "parses eventcallbackurl details" do
    response = Mailjet::Eventcallbackurl::CreateResponse.from_json(
      read_fixture("eventcallbackurl/one"))
    resource = response.data.first
    resource.api_key_id.should eq(1234567)
    resource.event_type.should eq("open")
    resource.id.should eq(987654)
    resource.is_backup.should be_false
    resource.status.should eq("alive")
    resource.url.should eq("https://somesite.com/123/")
    resource.version.should eq(1)
  end
end

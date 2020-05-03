require "../../spec_helper.cr"

describe Mailjet::Listrecipient do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all listrecipients" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/listrecipient")
        .to_return(status: 200, body: read_fixture("listrecipient/all"))

      response = Mailjet::Listrecipient.all
      response.data.first.should be_a(Mailjet::Listrecipient::Join)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single listrecipient" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/listrecipient/66712")
        .to_return(status: 200, body: read_fixture("listrecipient/one"))

      response = Mailjet::Listrecipient.find(66712)
      response.should be_a(Mailjet::Listrecipient::Join)
    end
  end

  describe ".create" do
    it "creates a new listrecipient" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/listrecipient")
        .to_return(status: 200, body: read_fixture("listrecipient/one"))

      response = Mailjet::Listrecipient.create({
        name: "Listrecipient 1",
      })
      response.should be_a(Mailjet::Listrecipient::Join)
    end
  end

  describe ".update" do
    it "updates an existing listrecipient" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/listrecipient/66712")
        .to_return(status: 200, body: read_fixture("listrecipient/one"))

      response = Mailjet::Listrecipient.update(66712, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Listrecipient::Join)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/listrecipient/66712")
        .to_return(status: 304, body: "")

      response = Mailjet::Listrecipient.update(66712)
      response.should be_nil
    end
  end

  describe ".delete" do
    it "deletes an existing listrecipient" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/REST/listrecipient/66712")
        .to_return(status: 204, body: "")

      response = Mailjet::Listrecipient.delete(66712)
      response.should be_nil
    end
  end
end

describe Mailjet::Listrecipient::Join do
  it "parses listrecipient details" do
    response = Mailjet::Listrecipient::CreateResponse.from_json(
      read_fixture("listrecipient/one"))
    resource = response.data.first
    resource.contact_id.should eq(53339566)
    resource.id.should eq(43877792)
    resource.is_active.should be_true
    resource.is_unsubscribed.should be_false
    resource.list_id.should eq(26667)
    resource.list_name.should eq("MyFirstTest")
    resource.subscribed_at.should be_nil
    resource.unsubscribed_at.should eq(Time.parse_rfc3339("2020-04-19T07:32:09Z"))
  end
end

require "../../spec_helper.cr"

describe Mailjet::Metasender do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all metasenders" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/metasender")
        .to_return(status: 200, body: read_fixture("metasender/all"))

      response = Mailjet::Metasender.all
      response.data.first.should be_a(Mailjet::Metasender::Details)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single metasender" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/metasender/13245")
        .to_return(status: 200, body: read_fixture("metasender/one"))

      response = Mailjet::Metasender.find(13245)
      response.should be_a(Mailjet::Metasender::Details)
    end
  end

  describe ".create" do
    it "creates a new metasender" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/metasender")
        .to_return(status: 200, body: read_fixture("metasender/one"))

      response = Mailjet::Metasender.create({
        description: "Metasender 2 - used for Promo emails",
        email:       "info@some.one",
      })
      response.should be_a(Mailjet::Metasender::Details)
    end
  end

  describe ".update" do
    it "updates an existing metasender" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/metasender/13245")
        .to_return(status: 200, body: read_fixture("metasender/one"))

      response = Mailjet::Metasender.update(13245, {
        email: "info@someone.com",

      })
      response.should be_a(Mailjet::Metasender::Details)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/metasender/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Metasender.update(13245)
      response.should be_nil
    end
  end
end

describe Mailjet::Metasender::Details do
  it "parses metasender details" do
    response = Mailjet::Metasender::CreateResponse.from_json(
      read_fixture("metasender/one"))
    resource = response.data.first
    resource.created_at.should eq(Time.parse_rfc3339("2020-05-05T11:08:07Z"))
    resource.description.should eq("Metasender 1 - used for Promo emails")
    resource.email.should eq("some@one.com")
    resource.filename.should eq("61b25373360fddea3d66a7c4e8fd17ad.txt")
    resource.id.should eq(883)
    resource.is_enabled.should be_false
  end
end

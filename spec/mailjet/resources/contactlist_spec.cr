require "../../spec_helper.cr"

describe Mailjet::Contactlist do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all contactlists" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contactlist")
        .to_return(status: 200, body: read_fixture("contactlist/all"))

      response = Mailjet::Contactlist.all
      response.data.first.should be_a(Mailjet::Contactlist::Details)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single contactlist" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contactlist/13245")
        .to_return(status: 200, body: read_fixture("contactlist/one"))

      response = Mailjet::Contactlist.find(13245)
      response.should be_a(Mailjet::Contactlist::Details)
    end
  end

  describe ".create" do
    it "creates a new contactlist" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/contactlist")
        .to_return(status: 200, body: read_fixture("contactlist/one"))

      response = Mailjet::Contactlist.create({
        name: "Contactlist 1",
      })
      response.should be_a(Mailjet::Contactlist::Details)
    end
  end

  describe ".update" do
    it "updates an existing contactlist" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/contactlist/13245")
        .to_return(status: 200, body: read_fixture("contactlist/one"))

      response = Mailjet::Contactlist.update({id: 13245}, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Contactlist::Details)
    end
  end
end

describe Mailjet::Contactlist::Details do
  it "parses contactlist details" do
    response = Mailjet::Contactlist::CreateResponse.from_json(
      read_fixture("contactlist/one"))
    resource = response.data.first
    resource.address.should eq("t8if2pl9z")
    resource.created_at.should eq(Time.parse_rfc3339("2020-04-19T07:32:09Z"))
    resource.id.should eq(24447)
    resource.is_deleted.should eq(false)
    resource.name.should eq("MyFirstTest")
    resource.subscriber_count.should eq(101)
  end
end

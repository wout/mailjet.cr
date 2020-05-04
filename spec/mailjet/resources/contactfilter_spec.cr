require "../../spec_helper.cr"

describe Mailjet::Contactfilter do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all contactfilters" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contactfilter")
        .to_return(status: 200, body: read_fixture("contactfilter/all"))

      response = Mailjet::Contactfilter.all
      response.data.first.should be_a(Mailjet::Contactfilter::Filter)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single contactfilter" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contactfilter/13245")
        .to_return(status: 200, body: read_fixture("contactfilter/one"))

      response = Mailjet::Contactfilter.find(13245)
      response.should be_a(Mailjet::Contactfilter::Filter)
    end
  end

  describe ".create" do
    it "creates a new contactfilter" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/contactfilter")
        .to_return(status: 200, body: read_fixture("contactfilter/one"))

      response = Mailjet::Contactfilter.create({
        name: "Contactfilter 1",
      })
      response.should be_a(Mailjet::Contactfilter::Filter)
    end
  end

  describe ".update" do
    it "updates an existing contactfilter" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/contactfilter/13245")
        .to_return(status: 200, body: read_fixture("contactfilter/one"))

      response = Mailjet::Contactfilter.update(13245, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Contactfilter::Filter)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/contactfilter/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Contactfilter.update(13245)
      response.should be_nil
    end
  end

  describe ".delete" do
    it "deletes an existing contactfilter" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/REST/contactfilter/13245")
        .to_return(status: 204, body: "")

      response = Mailjet::Contactfilter.delete(13245)
      response.should be_nil
    end
  end
end

describe Mailjet::Contactfilter::Filter do
  it "parses contactfilter details" do
    response = Mailjet::Contactfilter::CreateResponse.from_json(
      read_fixture("contactfilter/one"))
    resource = response.data.first
    # resource.address.should eq("t8if2pl9z")
    # resource.created_at.should eq(Time.parse_rfc3339("2020-04-19T07:32:09Z"))
    # resource.id.should eq(24447)
    # resource.is_deleted.should eq(false)
    # resource.name.should eq("MyFirstTest")
    # resource.subscriber_count.should eq(101)
  end
end

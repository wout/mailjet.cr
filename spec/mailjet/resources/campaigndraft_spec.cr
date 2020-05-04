require "../../spec_helper.cr"

describe Mailjet::Campaigndraft do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all campaigndrafts" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/campaigndraft")
        .to_return(status: 200, body: read_fixture("campaigndraft/all"))

      response = Mailjet::Campaigndraft.all
      response.data.first.should be_a(Mailjet::Campaigndraft::Draft)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single campaigndraft" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/campaigndraft/13245")
        .to_return(status: 200, body: read_fixture("campaigndraft/one"))

      response = Mailjet::Campaigndraft.find(13245)
      response.should be_a(Mailjet::Campaigndraft::Draft)
    end
  end

  describe ".create" do
    it "creates a new campaigndraft" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/campaigndraft")
        .to_return(status: 200, body: read_fixture("campaigndraft/one"))

      response = Mailjet::Campaigndraft.create({
        locale:  "en_US",
        subject: "It's going to be fabulous!",
      })
      response.should be_a(Mailjet::Campaigndraft::Draft)
    end
  end

  describe ".update" do
    it "updates an existing campaigndraft" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/campaigndraft/13245")
        .to_return(status: 200, body: read_fixture("campaigndraft/one"))

      response = Mailjet::Campaigndraft.update(13245, {
        locale:  "en_US",
        subject: "It's going to be fabulous!",
      })
      response.should be_a(Mailjet::Campaigndraft::Draft)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/campaigndraft/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Campaigndraft.update(13245)
      response.should be_nil
    end
  end
end

describe Mailjet::Campaigndraft::Draft do
  it "parses campaigndraft details" do
    response = Mailjet::Campaigndraft::CreateResponse.from_json(
      read_fixture("campaigndraft/one"))
    resource = response.data.first
    resource.ax_fraction.should eq(0)
    resource.ax_fraction_name.should eq("")
    resource.contacts_list_id.should eq(23777)
    resource.created_at.should eq(Time.parse_rfc3339("2020-05-04T16:53:06Z"))
    resource.current.should eq(1983364)
    resource.delivered_at.should be_nil
    resource.edit_mode.should eq("tool2")
    resource.id.should eq(26220)
    resource.is_starred.should be_false
    resource.is_text_part_included.should be_true
    resource.locale.should eq("en_US")
    resource.modified_at.should eq(Time.parse_rfc3339("2020-05-04T16:53:50Z"))
    resource.preset.should eq("{}")
    resource.sender.should eq("26778")
    resource.sender_email.should eq("some@one.com")
    resource.sender_name.should eq("SomeOne")
    resource.status.should eq(1)
    resource.subject.should eq("First test")
    resource.template_id.should eq(1399391)
    resource.title.should eq("Untitled campaign")
    resource.url.should eq("")
    resource.used.should be_false
  end
end

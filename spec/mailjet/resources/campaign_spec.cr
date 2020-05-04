require "../../spec_helper.cr"

describe Mailjet::Campaign do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all campaigns" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/campaign")
        .to_return(status: 200, body: read_fixture("campaign/all"))

      response = Mailjet::Campaign.all
      response.data.first.should be_a(Mailjet::Campaign::Details)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single campaign" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/campaign/1234567890987654400")
        .to_return(status: 200, body: read_fixture("campaign/one"))

      response = Mailjet::Campaign.find(1234567890987654400)
      response.should be_a(Mailjet::Campaign::Details)
    end
  end

  describe ".update" do
    it "updates an existing campaign" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/campaign/1234567890987654400")
        .to_return(status: 200, body: read_fixture("campaign/one"))

      response = Mailjet::Campaign.update(1234567890987654400, {
        is_deleted: true,
        is_starred: false,
      })
      response.should be_a(Mailjet::Campaign::Details)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/campaign/1234567890987654400")
        .to_return(status: 304, body: "")

      response = Mailjet::Campaign.update(1234567890987654400)
      response.should be_nil
    end
  end
end

describe Mailjet::Campaign::Details do
  it "parses campaign details" do
    response = Mailjet::Campaign::FindResponse.from_json(
      read_fixture("campaign/one"))
    resource = response.data.first
    resource.is_deleted.should be_false
    resource.is_starred.should be_false
    resource.campaign_type.should eq(2)
    resource.click_tracked.should eq(1)
    resource.created_at.should eq(Time.parse_rfc3339("2018-01-01T00:00:00Z"))
    resource.custom_value.should eq("CustomTag")
    resource.first_message_id.should eq(1234567890987654400)
    resource.from_email.should eq("pilot@mailjet.com")
    resource.from_id.should eq(123456)
    resource.from_name.should eq("Your Mailjet Pilot")
    resource.has_html_count.should eq(1)
    resource.has_txt_count.should eq(1)
    resource.id.should eq(987654321234568000)
    resource.list_id.should eq(567890)
    resource.news_letter_id.should eq(3456789)
    resource.open_tracked.should eq(1)
    resource.segmentation_id.should eq(123)
    resource.send_end_at.should eq(Time.parse_rfc3339("2018-01-01T00:00:00Z"))
    resource.send_start_at.should eq(Time.parse_rfc3339("2018-01-01T00:00:00Z"))
    resource.spamass_score.should eq("0")
    resource.status.should eq(0)
    resource.subject.should eq("Your email flight plan!")
    resource.unsubscribe_tracked_count.should eq(0)
    resource.workflow_id.should eq(1234)
  end
end

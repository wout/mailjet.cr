require "../../spec_helper.cr"

describe Mailjet::DNS do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all dns settings" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/dns")
        .to_return(status: 200, body: read_fixture("dns/all"))

      response = Mailjet::DNS.all
      response.data.first.should be_a(Mailjet::DNS::Settings)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single dns settings record" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/dns/13245")
        .to_return(status: 200, body: read_fixture("dns/one"))

      response = Mailjet::DNS.find(13245)
      response.should be_a(Mailjet::DNS::Settings)
    end
  end
end

describe Mailjet::DNS::Settings do
  it "parses dns settings" do
    response = Mailjet::DNS::FindResponse.from_json(
      read_fixture("dns/one"))
    resource = response.data.first
    resource.dkim_record_name.should eq("mailjet._domainkey.somesite.com.")
    resource.dkim_record_value
      .should eq("k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqyO0029jeZ7a6pGH90XKJ3shAIT7VsXC+3tM3iHPszRITs6gkO6n2joYuAxSAUsiyc40yxmDioyK81ByJddMXPJYf89j2V3yfirRqLNvmKzaTcMXNxTavyuhc4qAvvB70WWNuMz1ipftlqpQmeCbhOArL9c19xrsydXKn8mAtlQIDAQAB")
    resource.dkim_status.should eq("OK")
    resource.domain.should eq("somesite.com")
    resource.id.should eq(4758666239)
    resource.is_check_in_progress.should be_false
    resource.last_check_at.should eq(Time.parse_rfc3339("2020-04-29T16:20:27Z"))
    resource.owner_ship_token.should eq("403b0fa55b336c35a5dd3c791706d259")
    resource.owner_ship_token_record_name
      .should eq("mailjet._403b0fa5.somesite.com.")
    resource.spf_record_value.should eq("v=spf1 include:spf.mailjet.com ?all")
    resource.spf_status.should eq("OK")
  end
end

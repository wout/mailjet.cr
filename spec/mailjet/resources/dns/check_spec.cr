require "../../../spec_helper.cr"

describe Mailjet::DNS::Check do
  before_each do
    configure_global_api_credentials
  end

  describe ".create" do
    it "check dns record validation status" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/dns/123456789/check")
        .to_return(status: 200, body: read_fixture("dns/check/post"))

      response = Mailjet::DNS::Check.create(123456789)
      response.should be_a(Mailjet::DNS::Check::Details)
    end
  end
end

describe Mailjet::DNS::Check::Details do
  it "parses dns check details" do
    response = Mailjet::DNS::Check::CreateResponse.from_json(
      read_fixture("dns/check/post"))
    resource = response.data.first
    resource.dkim_errors.should be_a(Array(String))
    resource.dkim_record_current_value
      .should contain("k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqyO0029")
    resource.dkim_status.should eq("OK")
    resource.spf_errors.should be_a(Array(String))
    resource.spf_records_current_values
      .should contain("v=spf1 include:spf.mailjet.com +a +mx +ip4:184.107.41.72 include:relay.mailchannels.net ~all")
    resource.spf_status.should eq("OK")
  end
end

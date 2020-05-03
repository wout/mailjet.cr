require "../../../spec_helper.cr"

describe Mailjet::Contact::List do
  before_each do
    configure_global_api_credentials
  end

  it "fetches all lists a given contact is subscribed to" do
    WebMock.stub(:get,
      "https://api.mailjet.com/v3/REST/contact/52856550/getcontactslists")
      .to_return(status: 200, body: read_fixture("contact/list/all"))

    response = Mailjet::Contact::List.all(params: {contact_id: 52856550})
    response.data.first.should be_a(Mailjet::Contact::List::Details)
    response.count.should eq(1)
    response.total.should eq(1)
  end

  it "provides a convenience method to fetch a list by id alone" do
    WebMock.stub(:get,
      "https://api.mailjet.com/v3/REST/contact/52856551/getcontactslists")
      .to_return(status: 200, body: read_fixture("contact/list/all"))

    response = Mailjet::Contact::List.all(52856551)
    response.should be_a(Array(Mailjet::Contact::List::Details))
  end
end

describe Mailjet::Contact::List::Details do
  it "parses contact list subscription details" do
    response = Mailjet::Contact::List::ListResponse.from_json(
      read_fixture("contact/list/all"))
    resource = response.data.first
    resource.is_active.should eq(true)
    resource.is_unsub.should eq(false)
    resource.list_id.should eq(23847)
    resource.subscribed_at.should eq(Time.parse_rfc3339("2020-04-19T07:32:09Z"))
  end
end

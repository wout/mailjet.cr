describe Mailjet::Contact do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all contacts" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contact")
        .to_return(status: 200, body: read_fixture("contact/all"))

      response = Mailjet::Contact.all
      response.data.first.should be_a(Mailjet::Contact::Details)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single contact by params" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contact/52856551")
        .to_return(status: 200, body: read_fixture("contact/find"))

      response = Mailjet::Contact.find({id: 52856551})
      response.should be_a(Mailjet::Contact::Details)
    end

    it "fetches a single contact by id" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/contact/52856552")
        .to_return(status: 200, body: read_fixture("contact/find"))

      response = Mailjet::Contact.find(52856552)
      response.should be_a(Mailjet::Contact::Details)
    end
  end

  describe ".create" do
    it "creates a new contact" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/contact")
        .to_return(status: 200, body: read_fixture("contact/create"))

      response = Mailjet::Contact.create({
        name:                       "Contact 1",
        email:                      "user@example.com",
        is_excluded_from_campaigns: false,
      })
      response.should be_a(Mailjet::Contact::Details)
    end
  end

  describe ".update" do
    it "updates an existing contact" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/contact/52856553")
        .to_return(status: 200, body: read_fixture("contact/update"))

      response = Mailjet::Contact.update({id: 52856553}, {
        name:                       "Updated name",
        is_excluded_from_campaigns: false,
      })
      response.should be_a(Mailjet::Contact::Details)
    end
  end
end

describe Mailjet::Contact::Details do
  it "parses contact details" do
    response = Mailjet::Contact::CreateResponse.from_json(
      read_fixture("contact/create"))
    resource = response.data.first
    resource.delivered_count.should eq(0)
    resource.email.should eq("user@example.com")
    resource.exclusion_from_campaigns_updated_at.should be_nil
    resource.id.should eq(52856551)
    resource.is_excluded_from_campaigns.should be_false
    resource.is_opt_in_pending.should be_false
    resource.is_spam_complaining.should be_false
    resource.last_activity_at.should be_nil
    resource.last_update_at.should be_nil
    resource.name.should eq("Contact 1")
    resource.unsubscribed_at.should be_nil
    resource.unsubscribed_by.should be_nil
  end
end

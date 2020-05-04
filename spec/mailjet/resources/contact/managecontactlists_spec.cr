require "../../../spec_helper.cr"

describe Mailjet::Contact::Managecontactlists do
  before_each do
    configure_global_api_credentials
  end

  it "adds a contact to one or more lists" do
    WebMock.stub(:post, "https://api.mailjet.com/v3/REST/contact/54321987/managecontactslists")
      .with(body: test_managecontactlists_payload)
      .to_return(status: 200, body: read_fixture("contact/managecontactlists/create"))

    response = Mailjet::Contact::Managecontactlists.create({
      contacts_lists: [
        {
          list_id: 23847,
          action:  "addnoforce",
        },
        {
          list_id: 26484,
          action:  "addforce",
        },
      ],
    }, {contact_id: 54321987})
    contacts_lists = response["ContactsLists"]
    contacts_lists.first.list_id.should eq(23847)
    contacts_lists.first.action.should eq("addnoforce")
  end

  it "provides a conenvience method for adding contacts to a list" do
    WebMock.stub(:post, "https://api.mailjet.com/v3/REST/contact/54321987/managecontactslists")
      .with(body: test_managecontactlists_payload)
      .to_return(status: 200, body: read_fixture("contact/managecontactlists/create"))

    contacts_lists = Mailjet::Contact::Managecontactlists.create(54321987, [
      {list_id: 23847, action: "addnoforce"},
      {list_id: 26484, action: "addforce"},
    ])
    contacts_lists.first.list_id.should eq(23847)
    contacts_lists.first.action.should eq("addnoforce")
  end
end

private def test_managecontactlists_payload
  %({
    "ContactsLists": [
      {
        "ListId": 23847,
        "Action": "addnoforce"
      },
      {
        "ListId": 26484,
        "Action": "addforce"
      }
    ]
  }).gsub(/\s/, "")
end

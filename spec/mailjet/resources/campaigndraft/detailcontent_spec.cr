require "../../../spec_helper.cr"

describe Mailjet::Campaigndraft::Detailcontent do
  before_each do
    configure_global_api_credentials
  end

  describe ".find" do
    it "fetches detailcontent for a given campaigndraft" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/campaigndraft/13245/detailcontent")
        .to_return(status: 200, body: read_fixture("campaigndraft/detailcontent/one"))

      response = Mailjet::Campaigndraft::Detailcontent.find(13245)
      response.should be_a(JSON::Any)
    end
  end

  describe ".create" do
    it "creates detailcontent for a given campaigndraft" do
      WebMock.stub(:post,
        "https://api.mailjet.com/v3/REST/campaigndraft/13245/detailcontent")
        .to_return(status: 201, body: read_fixture("campaigndraft/detailcontent/one"))

      response = Mailjet::Campaigndraft::Detailcontent.create(13245, {
        author:     "John Doe",
        categories: [
          "commerce",
        ],
        copyright:   "John Doe",
        description: "Used for discount promotion.",
      })
      response.should be_a(JSON::Any)
    end
  end
end

private def test_campaigndraft_detailcontent
  {
    "Headers": {
      "Subject":  "Hello There!",
      "From":     "John Doe <email@example.com>",
      "Reply-To": "",
    },
    "Html-part": "<html><body><p>Hello {{var:name}}</p></body></html>",
    "Text-part": "Hello {{var:name}}",
    "Mjml-part": "",
  }
end

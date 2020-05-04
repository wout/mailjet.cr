require "../../../spec_helper.cr"

describe Mailjet::Template::Detailcontent do
  before_each do
    configure_global_api_credentials
  end

  describe ".find" do
    it "fetches detailcontent for a given template" do
      WebMock.stub(:get,
        "https://api.mailjet.com/v3/REST/template/13245/detailcontent")
        .to_return(status: 200, body: read_fixture("template/detailcontent/one"))

      response = Mailjet::Template::Detailcontent.find(13245)
      response.should be_a(JSON::Any)
    end
  end

  describe ".create" do
    it "creates detailcontent for a given template" do
      WebMock.stub(:post,
        "https://api.mailjet.com/v3/REST/template/13245/detailcontent")
        .to_return(status: 201, body: read_fixture("template/detailcontent/one"))

      response = Mailjet::Template::Detailcontent.create(13245, {
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

  describe ".update" do
    it "updates detailcontent for a given template" do
      WebMock.stub(:put,
        "https://api.mailjet.com/v3/REST/template/13245/detailcontent")
        .to_return(status: 200, body: read_fixture("template/detailcontent/one"))

      response = Mailjet::Template::Detailcontent.update(13245, {
        author:     "John Doe",
        categories: [
          "commerce",
        ],
        copyright:   "John Doe",
        description: "Used for discount promotion.",
      })
      response.should be_a(JSON::Any)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put,
        "https://api.mailjet.com/v3/REST/template/13245/detailcontent")
        .to_return(status: 304, body: "")

      response = Mailjet::Template::Detailcontent.update(13245)
      response.should be_nil
    end
  end
end

private def test_template_detailcontent
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

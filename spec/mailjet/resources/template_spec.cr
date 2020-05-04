require "../../spec_helper.cr"

describe Mailjet::Template do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "fetches all templates" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/template")
        .to_return(status: 200, body: read_fixture("template/all"))

      response = Mailjet::Template.all
      response.data.first.should be_a(Mailjet::Template::Details)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "fetches a single template" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/REST/template/13245")
        .to_return(status: 200, body: read_fixture("template/one"))

      response = Mailjet::Template.find(13245)
      response.should be_a(Mailjet::Template::Details)
    end
  end

  describe ".create" do
    it "creates a new template" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/template")
        .to_return(status: 200, body: read_fixture("template/one"))

      response = Mailjet::Template.create({
        name: "Template 1",
      })
      response.should be_a(Mailjet::Template::Details)
    end
  end

  describe ".update" do
    it "updates an existing template" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/template/13245")
        .to_return(status: 200, body: read_fixture("template/one"))

      response = Mailjet::Template.update(13245, {
        name: "Updated name",
      })
      response.should be_a(Mailjet::Template::Details)
    end

    it "performs an update request without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/REST/template/13245")
        .to_return(status: 304, body: "")

      response = Mailjet::Template.update(13245)
      response.should be_nil
    end
  end

  describe ".delete" do
    it "deletes an existing template" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/REST/template/13245")
        .to_return(status: 204, body: "")

      response = Mailjet::Template.delete(13245)
      response.should be_nil
    end
  end
end

private def test_template_payload
  {
    "Author":     "John Doe",
    "Categories": [
      "commerce",
    ],
    "Copyright":                   "John Doe",
    "Description":                 "Used for discount promotion.",
    "EditMode":                    1,
    "IsStarred":                   true,
    "IsTextPartGenerationEnabled": true,
    "Locale":                      "en_US",
    "Name":                        "Promo Code",
    "OwnerType":                   "apikey",
    "Purposes":                    [
      "marketing",
    ],
    "Presets": <<-JSON
      {
        "h1": {
          "fontFamily":"'Arial Black', Helvetica, Arial, sans-serif"
        }
      }
    JSON
  }
end

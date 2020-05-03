require "../spec_helper.cr"

describe Mailjet::Resource do
  before_each do
    configure_global_api_credentials
  end

  describe ".all" do
    it "finds many of the same resource" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/testresource")
        .to_return(status: 200, body: read_fixture("testresource/all"))

      response = Mailjet::Testresource.all
      response.data.first.should be_a(Mailjet::Testresource::Data)
      response.size.should eq(2)
      response.count.should eq(2)
      response.total.should eq(2)
    end
  end

  describe ".find" do
    it "finds a resource" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/testresource/123456789")
        .to_return(status: 200, body: read_fixture("testresource/one"))

      response = Mailjet::Testresource.find(123456789)
      response.should be_a(Mailjet::Testresource::Data)
    end

    it "fails to find a missing resource" do
      WebMock.stub(:get, "https://api.mailjet.com/v3/testresource/0")
        .to_return(status: 404, body: read_fixture("testresource/404"))

      expect_raises(Mailjet::ResourceNotFoundException) do
        Mailjet::Testresource.find(0)
      end
    end
  end

  describe ".create" do
    it "creates a resource" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/testresource")
        .to_return(status: 200, body: read_fixture("testresource/one"))

      response = Mailjet::Testresource.create({
        name:   "Unicorns",
        active: true,
      })
      response.should be_a(Mailjet::Testresource::Data)
    end

    it "fails to create when payload is incomplete" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/testresource")
        .to_return(status: 400, body: read_fixture("testresource/400"))

      expect_raises(Mailjet::RequestException) do
        Mailjet::Testresource.create({} of String => String)
      end
    end
  end

  describe ".update" do
    it "updates a resource" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/testresource/123456789")
        .to_return(status: 200, body: read_fixture("testresource/one"))

      response = Mailjet::Testresource.update(123456789, {
        name:   "Rainbows",
        active: false,
      })
      response.should be_a(Mailjet::Testresource::Data)
    end

    it "performs an update without changes" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/testresource/123456789")
        .to_return(status: 304, body: "")

      response = Mailjet::Testresource.update(123456789, {
        name:   "Rainbows",
        active: false,
      })
      response.should be_nil
    end

    it "fails to update a missing resource" do
      WebMock.stub(:put, "https://api.mailjet.com/v3/testresource/0")
        .to_return(status: 404, body: read_fixture("testresource/404"))

      expect_raises(Mailjet::ResourceNotFoundException) do
        Mailjet::Testresource.update(0, {
          name: "Green",
        })
      end
    end
  end

  describe ".delete" do
    it "deletes a resource" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/testresource/123456789")
        .to_return(status: 204, body: "")

      response = Mailjet::Testresource.delete(123456789)
      response.should be_nil
    end

    it "fails to delete a missing resource" do
      WebMock.stub(:delete, "https://api.mailjet.com/v3/testresource/0")
        .to_return(status: 404, body: read_fixture("testresource/404"))

      expect_raises(Mailjet::ResourceNotFoundException) do
        Mailjet::Testresource.delete(0)
      end
    end
  end
end

struct Mailjet::Testresource < Mailjet::Resource
  alias ResponseData = Array(Data)

  can_list("testresource", ResponseData)
  can_find("testresource/:id", ResponseData)
  can_create("testresource", ResponseData)
  can_update("testresource/:id", ResponseData)
  can_delete("testresource/:id")

  struct Data
    include Mailjet::Json::Fields

    json_fields({
      "Active":    Bool,
      "CreatedAt": Time,
      "ID":        Int32,
      "Name":      String,
      "NerdAt":    {type: Time, converter: Time::EpochConverter},
      "UpdatedAt": Time?,
    })
  end
end

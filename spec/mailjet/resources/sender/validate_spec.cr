require "../../../spec_helper.cr"

describe Mailjet::Sender::Validate do
  before_each do
    configure_global_api_credentials
  end

  describe ".create" do
    it "creates a new sender" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/REST/sender/1234/validate")
        .to_return(status: 200, body: read_fixture("sender/validate/post"))

      response = Mailjet::Sender::Validate.create(1234)
      response.should be_a(Mailjet::Sender::Validate::CreateResponse)
      response.validation_method.should eq("ActivationEmail")
      response.errors["FileValidationError"].should eq("")
      response.errors["DNSValidationError"].should eq("")
      response.global_error.should eq("")
    end
  end
end

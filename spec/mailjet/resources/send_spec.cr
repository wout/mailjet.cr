require "../../spec_helper.cr"

describe Mailjet::Send do
  before_each do
    configure_global_api_credentials
  end

  describe "#messages" do
    it "delivers one or more messages" do
      WebMock.stub(:post, "https://api.mailjet.com/v3.1/send")
        .to_return(status: 200, body: read_fixture("send/create"))

      response = Mailjet::Send.messages([
        valid_send_message_payload,
        valid_send_message_payload,
      ])
      response.messages.should be_a(Array(Mailjet::Send::ResponseMessage))
    end
  end
end

describe Mailjet::Send::CreateResponse do
  it "parses success messages" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create"))
    message = response.messages.first
    message.status.should eq("success")
    message.custom_id.should eq("")
    message.to.should be_a(Array(Mailjet::Send::DeliveryReceipt))
    message.cc.should be_a(Array(Mailjet::Send::DeliveryReceipt))
    message.bcc.should be_a(Array(Mailjet::Send::DeliveryReceipt))
  end

  it "parses error messages" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-all-errors"))
    message = response.messages.first
    message.status.should eq("error")
    message.errors.should be_a(Array(Mailjet::Send::DeliveryError))
  end
end

describe Mailjet::Send::DeliveryReceipt do
  it "parses a delivery receipt" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create"))
    message = response.messages.first
    receipt = message.to.as(Array(Mailjet::Send::DeliveryReceipt)).first
    receipt.email.should eq("some@one.com")
    receipt.uuid.should eq("60fe9f5e-d7a1-460b-b0dc-53b0d021f1c8")
    receipt.href.should contain("https://api.mailjet.com/v3/REST/message")
  end
end

describe Mailjet::Send::DeliveryReceipt do
  it "parses a delivery error" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-all-errors"))
    message = response.messages.last
    error = message.errors.as(Array(Mailjet::Send::DeliveryError)).first
    error.identifier.should eq("6ceb8d18-3367-4fc9-869e-533e93f87c6e")
    error.error_code.should eq("send-0003")
    error.status_code.should eq(400)
    error.message.should contain("At least")
    error.related_to.should eq(%w[TextPart HTMLPart TemplateID])
  end
end

private def valid_send_message_payload
  {
    "From": {
      "Email": "from@email.com",
      "Name":  "Me",
    },
    "To": [
      {
        "Email": "to@email.com",
        "Name":  "You",
      },
    ],
    "Subject":  "My first Mailjet Email!",
    "TextPart": "Greetings from Mailjet!",
    "HTMLPart": <<-TEXT
      <h3>Dear passenger 1, welcome to
      <a href='https://www.mailjet.com/'>Mailjet</a>!
      </h3><br />May the delivery force be with you!
    TEXT
  }
end

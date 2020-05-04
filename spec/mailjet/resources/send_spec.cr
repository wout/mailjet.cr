require "../../spec_helper.cr"

describe Mailjet::Send do
  before_each do
    configure_global_api_credentials
  end

  describe "#messages" do
    it "delivers one or more messages using the v3.1 api" do
      WebMock.stub(:post, "https://api.mailjet.com/v3.1/send")
        .to_return(status: 200, body: read_fixture("send/create-v3.1"))

      messages = Mailjet::Send.messages([
        valid_send_message_payload_v3_1,
        valid_send_message_payload_v3_1,
      ])
      messages.should be_a(Array(Mailjet::Send::ResponseMessage))
    end

    it "delivers one or more messages using the v3 api" do
      WebMock.stub(:post, "https://api.mailjet.com/v3/send")
        .to_return(status: 200, body: read_fixture("send/create-v3"))

      sent = Mailjet::Send.messages([
        valid_send_message_payload_v3,
        valid_send_message_payload_v3,
      ], "v3")
      sent.should be_a(Array(Mailjet::Send::SentMessage))
    end
  end
end

describe Mailjet::Send::CreateResponse do
  it "parses success messages" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-v3.1"))
    message = response.messages.as(Array(Mailjet::Send::ResponseMessage)).first
    message.status.should eq("success")
    message.custom_id.should eq("")
    message.to.should be_a(Array(Mailjet::Send::DeliveryReceipt))
    message.cc.should be_a(Array(Mailjet::Send::DeliveryReceipt))
    message.bcc.should be_a(Array(Mailjet::Send::DeliveryReceipt))
  end

  it "parses error messages" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-all-errors"))
    message = response.messages.as(Array(Mailjet::Send::ResponseMessage)).first
    message.status.should eq("error")
    message.errors.should be_a(Array(Mailjet::Send::DeliveryError))
  end
end

describe Mailjet::Send::DeliveryReceipt do
  it "parses a delivery receipt" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-v3.1"))
    message = response.messages.as(Array(Mailjet::Send::ResponseMessage)).first
    receipt = message.to.as(Array(Mailjet::Send::DeliveryReceipt)).first
    receipt.email.should eq("some@one.com")
    receipt.message_id.should eq(576464555653964483)
    receipt.message_uuid.should eq("60fe9f5e-d7a1-460b-b0dc-53b0d021f1c8")
    receipt.message_href
      .should eq("https://api.mailjet.com/v3/REST/message/576464555653964483")
  end
end

describe Mailjet::Send::DeliveryReceipt do
  it "parses a delivery error" do
    response = Mailjet::Send::CreateResponse.from_json(
      read_fixture("send/create-all-errors"))
    message = response.messages.as(Array(Mailjet::Send::ResponseMessage)).last
    error = message.errors.as(Array(Mailjet::Send::DeliveryError)).first
    error.error_identifier.should eq("6ceb8d18-3367-4fc9-869e-533e93f87c6e")
    error.error_code.should eq("send-0003")
    error.status_code.should eq(400)
    error.error_message.should contain("At least")
    error.error_related_to.should eq(%w[TextPart HTMLPart TemplateID])
  end
end

private def valid_send_message_payload_v3_1
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
    "HTMLPart": <<-HTML
      <h3>Dear passenger 1, welcome to
      <a href='https://www.mailjet.com/'>Mailjet</a>!
      </h3><br />May the delivery force be with you!
    HTML
  }
end

private def valid_send_message_payload_v3
  {
    "FromEmail":  "pilot@mailjet.com",
    "FromName":   "Your Mailjet Pilot",
    "Recipients": [
      {
        "Email": "passenger@mailjet.com",
        "Name":  "Passenger 1",
      },
    ],
    "Subject":   "Your email flight plan!",
    "Text-part": "Dear passenger, welcome to Mailjet!",
    "Html-part": <<-HTML
      <h3>Dear passenger, welcome to Mailjet!</h3>
      <br />
      May the delivery force be with you!
    HTML
  }
end

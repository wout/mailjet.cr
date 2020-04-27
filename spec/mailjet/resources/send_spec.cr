require "../../spec_helper.cr"

describe Mailjet::Send do
  describe ".resource_path" do
    it "returns the resource path" do
      Mailjet::Send.resource_path.should eq("send")
    end
  end

  describe ".public_operations" do
    it "returns the allowed methods" do
      Mailjet::Send.public_operations.should eq(%w[POST])
    end
  end

  describe ".create" do
    it "sends messages" do
      Mailjet::Send.messages([test_send_message])
    end
  end
end

private def test_send_message
  {
    "From" => {
      "Email" => "$SENDER_EMAIL",
      "Name"  => "Me",
    },
    "To" => [
      {
        "Email" => "$RECIPIENT_EMAIL",
        "Name"  => "You",
      },
    ],
    "Subject"  => "My first Mailjet Email!",
    "TextPart" => "Greetings from Mailjet!",
    "HTMLPart" => <<-TEXT
      <h3>Dear passenger 1, welcome to
      <a href='https://www.mailjet.com/'>Mailjet</a>!
      </h3><br />May the delivery force be with you!
    TEXT
  }
end

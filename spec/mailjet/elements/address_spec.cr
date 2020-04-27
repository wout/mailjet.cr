require "../../spec_helper.cr"

describe Mailjet::Address do
  describe ".initialize" do
    it "parses a given email address" do
      email = Mailjet::Address.new("Mick Blink <mick.blink@mailjet.com>")
      email.address.should eq("mick.blink@mailjet.com")
    end

    it "only parses the first email address in a given list" do
      email = Mailjet::Address.new("A B <a@b.c>, D E <d@e.f>")
      email.address.should eq("a@b.c")
      email.display_name.should eq("A B")
    end

    it "can be initialized with a parsed addess and display name" do
      email = Mailjet::Address.new("ben@mailjet.com", "Just Ben")
      email.address.should eq("ben@mailjet.com")
      email.display_name.should eq("Just Ben")
    end
  end

  describe "#address" do
    it "returns the email address alone" do
      test_email_address.address.should eq("mick.blink@mailjet.com")
    end
  end

  describe "#display_name" do
    it "returns the name alone" do
      test_email_address.display_name.should eq("Mick Blink")
    end
  end

  describe "#address_list" do
    it "returns the unparsed value" do
      test_email_address.address_list
        .should eq("Mick Blink <mick.blink@mailjet.com>")
    end
  end
end

private def test_email_address
  Mailjet::Address.new("Mick Blink <mick.blink@mailjet.com>")
end

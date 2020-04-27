require "../../spec_helper.cr"

describe Mailjet::AddressList do
  describe ".initialize" do
    it "parses a single address" do
      list = Mailjet::AddressList.new("Me He <me@he.com>")
      list.first.address.should eq("me@he.com")
      list.first.display_name.should eq("Me He")
    end

    it "parses multiple addreses" do
      list = Mailjet::AddressList.new("Me He <me@he.com>, we@them.com, a@b.c")
      list.size.should eq(3)
      list[0].display_name.should eq("Me He")
      list[0].address.should eq("me@he.com")
      list[1].display_name.should eq("")
      list[1].address.should eq("we@them.com")
      list[2].display_name.should eq("")
      list[2].address.should eq("a@b.c")
    end

    it "handles oddly formatted addresses" do
      addresses = [
        %(disposable.style.email.with+symbol@example.com),
        %(other.email-with-hyphen@example.com),
        %(fully-qualified-domain@example.com),
        %(user.name+tag+sorting@example.com),
        %(x@example.com),
        %(example-indeed@strange-example.com),
        %(admin@mailserver1),
        %(example@s.example),
        %(" "@example.org),
        %("john..doe"@example.org),
        %(mailhost!username@example.org),
        %(user%example.com@example.org),
      ]

      addresses.each do |address|
        email = Mailjet::AddressList.new(address).first
        email.address.should eq(address)
        email.display_name.should eq("")
      end
    end
  end

  describe "#addresses" do
    it "returns a list with email addresses" do
      list = test_email_address_list
      list.size.should eq(2)
    end
  end

  describe "delegations" do
    it "sends missing methods directly to addreses" do
      test_email_address_list.size.should eq(2)
      test_email_address_list.map(&.address[0]).should eq(['s', 'a'])
    end
  end
end

private def test_email_address_list
  Mailjet::AddressList.new("some@one.com, another@one.com")
end

require "../spec_helper.cr"

describe Mailjet::RequestException do
  describe "#initialize" do
    it "serializes json with an info string" do
      test_404_exception.status_code.should eq(404)
      test_404_exception.error_message.should eq("Object not found")
      test_404_exception.error_info.should eq("Something's wrong")
    end

    it "serializes json with an info array" do
      test_400_exception.status_code.should eq(400)
      test_400_exception.error_info.should be_a(Mailjet::Exception::ErrorInfoArray)
      test_400_exception.error_message.should eq("Object properties invalid")
      error_info = test_400_exception.error_info.as(Mailjet::Exception::ErrorInfoArray)
      errors = error_info["ContactsLists"].map(&.["Error"])
      errors.should contain("List ID 123456789 is invalid or deleted")
      errors.should contain("List ID 987654321 is invalid or deleted")
    end
  end

  describe "#message" do
    it "compiles a message based on api response" do
      test_404_exception.to_s.should eq("Object not found (404)")
    end
  end

  describe "#to_s" do
    it "is an alias for message" do
      test_404_exception.to_s.should eq(test_404_exception.message)
    end
  end
end

private def test_404_exception
  Mailjet::RequestException.from_json(
    read_fixture("exceptions/404"))
end

private def test_400_exception
  Mailjet::RequestException.from_json(
    read_fixture("exceptions/400-managecontactlists"))
end

require "../spec_helper.cr"

describe Mailjet::RequestException do
  describe "#initialize" do
    it "serializes json" do
      test_request_exception.status_code.should eq(404)
      test_request_exception.error_info.should eq("Something's wrong")
      test_request_exception.error_message.should eq("Object not found")
    end
  end

  describe "#message" do
    it "compiles a message based on api response" do
      test_request_exception.to_s.should start_with("Object not found")
      test_request_exception.to_s.should contain("(Something's wrong; ")
      test_request_exception.to_s.should end_with("404)")
    end
  end

  describe "#to_s" do
    it "is an alias for message" do
      test_request_exception.to_s.should eq(test_request_exception.message)
    end
  end
end

private def test_request_exception
  Mailjet::RequestException.from_json(example_not_found_response)
end

private def example_not_found_response
  %({
    "ErrorInfo" : "Something's wrong",
    "ErrorMessage" : "Object not found",
    "StatusCode" : 404
  })
end

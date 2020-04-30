require "../spec_helper"

describe Mailjet::Path do
  describe "#to_s" do
    context "without params" do
      it "converts to a path with default version" do
        path = Mailjet::TestPath.new
        path.to_s.should eq("/v3/test/path")
      end
    end

    context "with params" do
      it "interpolates the given params" do
        path = Mailjet::TestPathWithParams.new({
          test:   "aap",
          params: "noot",
        })
        path.to_s.should eq("/v3/test/path/aap/noot")
      end

      it "fails if not all required params are provided" do
        expect_raises(Mailjet::ParamsMissingException) do
          Mailjet::TestPathWithParams.new({
            params: "noot",
          }).to_s
        end
      end
    end

    context "with version" do
      it "it does not add the api version" do
        path = Mailjet::TestPathWithVersion.new
        path.to_s.should eq("/v3.1/test/path")
      end
    end

    context "without leading slash" do
      it "adds a leading slash" do
        path = Mailjet::TestPathWithoutLeadingSlash.new
        path.to_s.should eq("/v3/test/path")
      end
    end
  end
end

struct Mailjet
  struct TestPath < Mailjet::Path
    getter pattern = "/test/path"
  end

  struct TestPathWithParams < Mailjet::Path
    getter pattern = "/test/path/:test/:params"
  end

  struct TestPathWithVersion < Mailjet::Path
    getter pattern = "/v3.1/test/path"
  end

  struct TestPathWithoutLeadingSlash < Mailjet::Path
    getter pattern = "v3/test/path"
  end
end

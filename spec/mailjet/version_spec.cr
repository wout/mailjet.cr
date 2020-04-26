require "../spec_helper.cr"

describe Mailjet::VERSION do
  it "returns the current version" do
    Mailjet::VERSION.should eq(`git describe --abbrev=0 --tags`.strip)
  end
end

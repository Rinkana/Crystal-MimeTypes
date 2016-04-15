require "./spec_helper"

describe Mime do
  it "from_file" do
    Mime.from_file(File.open(File.join(__DIR__, "test.jpg"))).should be_a(Mime::MimeType)
    Mime.from_file(File.open(File.join(__DIR__, "test.png"))).should be_a(Mime::MimeType)
    Mime.from_file(File.open(File.join(__DIR__, "test.thisshouldnotwork"))).should be(nil)
  end

  it "from_extension" do
    Mime.from_extension("jpg").should be_a(Mime::MimeType)
    Mime.from_extension("test.png").should be(nil)
    Mime.from_extension(".png").should be(nil)
    Mime.from_extension("shouldnotwork").should be(nil)
  end
end

require 'rails_helper'

RSpec.describe Url, type: :model do
  it "is valid with valid attributes" do
    url = Url.new(original: "http://example.com", short: "abc123")
    expect(url).to be_valid
  end

  it "is invalid without an original URL" do
    url = Url.new(short: "abc123")
    expect(url).to_not be_valid
  end

  it "is invalid without a short code" do
    url = Url.new(original: "http://example.com")
    expect(url).to_not be_valid
  end
end

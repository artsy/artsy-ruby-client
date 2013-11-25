require 'spec_helper'

describe Artsy::Client::API::Feature do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#feature" do
    before do
      stub_get("/api/v1/feature/two-x-two").to_return(
        body: fixture("feature.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns feature" do
      feature = @client.feature('two-x-two')
      expect(a_get("/api/v1/feature/two-x-two")).to have_been_made
      expect(feature).to be_an Artsy::Client::Domain::Feature
      expect(feature.name).to eq "TWO x TWO"
    end
  end
end

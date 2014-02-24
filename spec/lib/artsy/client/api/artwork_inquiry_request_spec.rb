require 'spec_helper'

describe Artsy::Client::API::ArtworkInquiryRequest do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#artwork_inquiry_request" do
    before do
      stub_get("/api/v1/artwork_inquiry_request/ludvik").to_return(
        body: fixture("artwork_inquiry_request.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork_inquiry_request" do
      artwork_inquiry_request = @client.artwork_inquiry_request('ludvik')
      expect(a_get("/api/v1/artwork_inquiry_request/ludvik")).to have_been_made
      expect(artwork_inquiry_request).to be_an Artsy::Client::Domain::ArtworkInquiryRequest
      puts artwork_inquiry_request.email
      puts artwork_inquiry_request.message
      expect(artwork_inquiry_request.name).to eq "Ludvik Jahn"
    end
  end
  describe "#artwork_inquiry_requests" do
    before do
      stub_get("/api/v1/artwork_inquiry_requests").to_return(
        body: fixture("artwork_inquiry_requests.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork inquiry requests" do
      artwork_inquiry_requests = @client.artwork_inquiry_requests
      expect(a_get("/api/v1/artwork_inquiry_requests")).to have_been_made
      expect(artwork_inquiry_requests).to be_an Array
      expect(artwork_inquiry_requests.size).to eq 1
      expect(artwork_inquiry_requests.first.name).to eq "Ludvik Jahn"
    end
  end
end

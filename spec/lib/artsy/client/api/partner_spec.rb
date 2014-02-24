require 'spec_helper'

describe Artsy::Client::API::Partner do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#partner" do
    before do
      stub_get("/api/v1/partner/bitforms-gallery").to_return(
        body: fixture("partner.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns partner" do
      partner = @client.partner('bitforms-gallery')
      expect(a_get("/api/v1/partner/bitforms-gallery")).to have_been_made
      expect(partner).to be_an Artsy::Client::Domain::Partner
      expect(partner.name).to eq "bitforms gallery"
    end
  end
  describe "#create_partner" do
    before do
      stub_post("/api/v1/partner").to_return(
        body: fixture("partner.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns partner" do
      partner = @client.create_partner(given_name: 'bitforms gallery')
      expect(a_post("/api/v1/partner")).to have_been_made
      expect(partner).to be_an(Artsy::Client::Domain::Partner)
      expect(partner.name).to eq('bitforms gallery')
    end
  end
end

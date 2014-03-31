require 'spec_helper'

describe Artsy::Client::API::SaleArtwork do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#update_sale_artwork" do
    before do
      stub_put("/api/v1/sale/two-x-two/sale_artwork/two-x-two-artwork").to_return(
        body: fixture("sale_artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns sale artwork" do
      sale_artwork = @client.update_sale_artwork('two-x-two', 'two-x-two-artwork', opening_bid_cents: 100_00)
      expect(a_put("/api/v1/sale/two-x-two/sale_artwork/two-x-two-artwork")).to have_been_made
      expect(sale_artwork).to be_an Artsy::Client::Domain::SaleArtwork
      expect(sale_artwork.opening_bid_cents).to eq 100_00
    end
  end
  describe "#add_artwork_to_sale" do
    before do
      stub_post("/api/v1/sale/two-x-two/sale_artwork").to_return(
        body: fixture("sale_artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns sale" do
      sale_artwork = @client.add_artwork_to_sale('two-x-two', artwork_id: 'two-x-two-artwork')
      expect(a_post("/api/v1/sale/two-x-two/sale_artwork")).to have_been_made
      expect(sale_artwork).to be_an Artsy::Client::Domain::SaleArtwork
      expect(sale_artwork['artwork']['title']).to eq('TWO x TWO Artwork')
    end
  end
end

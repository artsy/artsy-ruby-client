require 'spec_helper'

describe Artsy::Client::API::ArtworkInventory do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#create_artwork_inventory" do
    before do
      stub_put("/api/v1/artwork/andy-warhol-skull/inventory").to_return(
        body: fixture("artwork_inventory.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork invetory" do
      artwork_inventory = @client.create_artwork_inventory(artwork_id: 'andy-warhol-skull')
      expect(a_put("/api/v1/artwork/andy-warhol-skull/inventory")).to have_been_made
      expect(artwork_inventory).to be_an Artsy::Client::Domain::ArtworkInventory
      expect(artwork_inventory.count).to eq 1
    end
  end
end

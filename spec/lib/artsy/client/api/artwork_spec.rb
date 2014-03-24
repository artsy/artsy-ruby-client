require 'spec_helper'

describe Artsy::Client::API::Artwork do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#artwork" do
    before do
      stub_get("/api/v1/artwork/andy-warhol-skull").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.artwork('andy-warhol-skull')
      expect(a_get("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      expect(artwork).to be_an Artsy::Client::Domain::Artwork
      expect(artwork.title).to eq "Skull"
      expect(artwork.artist.name).to eq "Andy Warhol"
    end
  end
  describe "#artwork.txt" do
    before do
      stub_get("/api/v1/artwork/andy-warhol-skull.txt").to_return(
        body: fixture("artwork.txt"),
        headers: { content_type: "text/plain" }
      )
    end
    it "returns artwork in ascii format" do
      artwork_txt = @client.artwork_txt('andy-warhol-skull')[:body]
      expect(a_get("/api/v1/artwork/andy-warhol-skull.txt")).to have_been_made
      expect(artwork_txt).to be_a String
      expect(artwork_txt).to start_with "+----------"
      expect(artwork_txt).to end_with "--------+"
    end
  end
  describe "#artwork.to_ascii" do
    before do
      stub_get("/api/v1/artwork/andy-warhol-skull.txt").to_return(
        body: fixture("artwork.txt"),
        headers: { content_type: "text/plain" }
      )
      stub_get("/api/v1/artwork/andy-warhol-skull").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork in ascii format" do
      artwork = @client.artwork('andy-warhol-skull')
      expect(a_get("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      artwork_txt = artwork.to_ascii
      expect(a_get("/api/v1/artwork/andy-warhol-skull.txt")).to have_been_made
      expect(artwork_txt).to be_a String
      expect(artwork_txt).to start_with "+----------"
      expect(artwork_txt).to end_with "--------+"
    end
  end
  describe "#create_artwork" do
    before do
      stub_post("/api/v1/artwork").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.create_artwork(title: 'Mona Lisa')
      expect(a_post("/api/v1/artwork")).to have_been_made
      expect(artwork).to be_an(Artsy::Client::Domain::Artwork)
      expect(artwork.title).to eq('Skull')
    end
  end
  describe "#update_artwork" do
    before do
      stub_put("/api/v1/artwork/andy-warhol-skull").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artwork" do
      artwork = @client.update_artwork('andy-warhol-skull', title: 'Marilyn')
      expect(a_put("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      expect(artwork).to be_an(Artsy::Client::Domain::Artwork)
      expect(artwork.title).to eq('Skull')
    end
  end
  describe "#update_artwork_inventory" do
    before do
      stub_put("/api/v1/artwork/andy-warhol-skull/inventory").to_return(
        body: fixture("artwork_inventory.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns inventory for an artwork" do
      artwork_inventory = @client.update_artwork_inventory('andy-warhol-skull')
      expect(a_put("/api/v1/artwork/andy-warhol-skull/inventory")).to have_been_made
      expect(artwork_inventory).to be_an Artsy::Client::Domain::Inventory
      expect(artwork_inventory.count).to eq 1
    end
  end
end

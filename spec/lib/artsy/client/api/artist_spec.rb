require 'spec_helper'

describe Artsy::Client::API::Artist do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#artist" do
    before do
      stub_get("/api/v1/artist/andy-warhol").to_return(
        body: fixture("artist.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artist" do
      artist = @client.artist('andy-warhol')
      expect(a_get("/api/v1/artist/andy-warhol")).to have_been_made
      expect(artist).to be_an Artsy::Client::Domain::Artist
      expect(artist.name).to eq "Andy Warhol"
    end
    context "#artworks" do
      before do
        stub_get("/api/v1/artist/andy-warhol/artworks").to_return(
          body: fixture("artist/artworks.json"),
          headers: { content_type: "application/json; charset=utf-8" }
        )
      end
      it "returns artist's artworks" do
        artist = @client.artist('andy-warhol')
        artworks = artist.artworks
        expect(artworks).to be_an Array
        expect(artworks.size).to eq 3
        expect(artworks.first.artist.name).to eq artist.name
      end
    end
  end
  describe "#artists" do
    before do
      stub_get("/api/v1/artists/sample").to_return(
        body: fixture("artists.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns artist" do
      artists = @client.artists
      expect(a_get("/api/v1/artists/sample")).to have_been_made
      expect(artists).to be_an Array
      expect(artists.size).to eq 3
      expect(artists.first.name).to eq "Georges Seurat"
    end
  end
end

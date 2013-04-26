require 'spec_helper'

describe Artsy::Client::API::Artwork do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#artwork" do
    before do
      stub_get("/api/v1/artwork/andy-warhol-skull").to_return({
        :body => fixture("artwork.json"), 
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns artwork" do
      artwork = @client.artwork('andy-warhol-skull')
      expect(a_get("/api/v1/artwork/andy-warhol-skull")).to have_been_made
      expect(artwork).to be_an Artsy::Client::Domain::Artwork
      expect(artwork.title).to eq "Skull"
      expect(artwork.artist.name).to eq "Andy Warhol"
    end
  end
  describe "#artworks" do
    before do
      stub_get("/api/v1/artworks/new").to_return({
        :body => fixture("artworks.json"), 
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns artwork" do
      artworks = @client.recently_published_artworks
      expect(a_get("/api/v1/artworks/new")).to have_been_made
      expect(artworks).to be_an Array
      expect(artworks.size).to eq 20
      expect(artworks.first.title).to eq "Coiffeuse"
    end
  end
end

require 'spec_helper'

describe Artsy::Client::API::Artist do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "artist" do
    before do
      stub_get("/api/v1/artist/andy-warhol").to_return({
        :body => fixture("artist.json"), 
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns artist" do
      artist = @client.artist('andy-warhol')
      expect(a_get("/api/v1/artist/andy-warhol")).to have_been_made
      expect(artist).to be_an Artsy::Client::Domain::Artist
      expect(artist.name).to eq "Andy Warhol"
    end
  end
end

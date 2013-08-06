require 'spec_helper'

describe Artsy::Client::API::Show do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#shows" do
    context "with cursor" do
      before do
        stub_get("/api/v1/shows/feed").to_return({
          :body => fixture("shows.1.json"),
          :headers => { :content_type => "application/json; charset=utf-8" }
        })
        stub_get("/api/v1/shows/feed?cursor=1366965419:5177dda3a2cb6053a8000023").to_return({
          :body => fixture("shows.2.json"),
          :headers => { :content_type => "application/json; charset=utf-8" }
        })
      end
      it "returns shows" do
        # first request
        shows = @client.shows
        expect(a_get("/api/v1/shows/feed")).to have_been_made
        expect(shows).to be_a Hash
        expect(shows[:results].size).to eq 3
        expect(shows[:next]).to_not be_nil
        show = shows[:results].first
        expect(show).to be_a Artsy::Client::Domain::Show
        expect(show.to_s).to eq 'Markus Bacher, "After Eight" | Thomas Kiesewetter, "Neue Skulpturen"'
        expect(show.name).to eq 'Markus Bacher, "After Eight" | Thomas Kiesewetter, "Neue Skulpturen"'
        Timecop.freeze(Time.local(2013))
        expect(show.when).to eq "Apr. 25 - May 31"
        Timecop.freeze(Time.local(2014))
        expect(show.when).to eq "Apr. 25 - May 31, 2013"
        expect(show.where).to eq "Berlin"
        partner = show.partner
        expect(partner).to be_a Artsy::Client::Domain::Partner
        expect(partner.to_s).to eq "Contemporary Fine Arts"
        artworks = show.artworks
        expect(artworks).to be_an Array
        artwork = artworks.first
        expect(artwork).to be_a Artsy::Client::Domain::Artwork
        artist = artwork.artist
        expect(artist).to be_a Artsy::Client::Domain::Artist
        expect(artist.to_s).to eq "Markus Bacher"
        expect(artwork.to_s).to eq "Markus Bacher, Dogs Bollogs (2012-2013)"
        # next request
        shows2 = @client.shows({ :cursor => shows[:next] })
        expect(a_get("/api/v1/shows/feed?cursor=1366965419:5177dda3a2cb6053a8000023")).to have_been_made
        expect(shows2).to be_a Hash
        expect(shows2[:results].size).to eq 3
        expect(shows2[:next]).to_not be_nil
        expect(shows2[:results].first).to be_a Artsy::Client::Domain::Show
        expect(shows2[:results].first.name).to eq 'Isa Genzken'
      end
    end
  end
  context "spanning mutliple years" do
    before do
      stub_get("/api/v1/shows/feed").to_return({
        :body => fixture("shows.3.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns shows that span multiple years" do
      # first request
      shows = @client.shows
      expect(a_get("/api/v1/shows/feed")).to have_been_made
      expect(shows).to be_a Hash
      expect(shows[:results].size).to eq 1
      expect(shows[:next]).to_not be_nil
      show = shows[:results].first
      expect(show).to be_a Artsy::Client::Domain::Show
      show.when.should == "Jun. 29, 2013 - Jan. 4 2014"
    end
  end
end

require 'spec_helper'

describe Artsy::Client::API::Show do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#show" do
    before do
      stub_get("/api/v1/show/longhouse-projects-the-other-side-and-in-between").to_return(
        body: fixture("show.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns show" do
      show = @client.show('longhouse-projects-the-other-side-and-in-between')
      expect(a_get("/api/v1/show/longhouse-projects-the-other-side-and-in-between")).to have_been_made
      expect(show).to be_an Artsy::Client::Domain::Show
      expect(show.name).to eq "Christopher Astley and Saira McLaren"
    end
    context "#artworks" do
      before do
        stub_get("/api/v1/partner/sargents-daughters/show/sargents-daughters-christopher-astley-and-saira-mclaren/artworks").to_return(
          body: fixture("show/artworks.json"),
          headers: { content_type: "application/json; charset=utf-8" }
        )
      end
      it "returns show's artworks" do
        show = @client.show('longhouse-projects-the-other-side-and-in-between')
        artworks = show.artworks
        expect(artworks).to be_an Array
        expect(artworks.size).to eq 10
        expect(artworks.first.title).to eq "Geometric 2"
      end
    end
  end
  describe "#shows" do
    before do
      stub_get("/api/v1/shows").to_return(
        body: fixture("shows.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns shows" do
      shows = @client.shows
      expect(a_get("/api/v1/shows")).to have_been_made
      expect(shows).to be_an Array
      expect(shows.size).to eq 10
      expect(shows.first.name).to eq "The Other Side and In Between"
    end
  end
end

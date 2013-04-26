require 'spec_helper'

describe Artsy::Client::API::Show do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#shows" do
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
      expect(shows[:results].first).to be_a Artsy::Client::Domain::Show
      expect(shows[:results].first.name).to eq 'Markus Bacher, "After Eight" | Thomas Kiesewetter, "Neue Skulpturen"'
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

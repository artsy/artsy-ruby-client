require 'spec_helper'

describe Artsy::Client::API::Match do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#match" do
    before do
      stub_get("/api/v1/match?term=andy").to_return({
        :body => fixture("match.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
      {
        "andy-warhol-limited-edition-prints-and-polaroids" => :feature,
        "andy-warhol-presented-by-christies" => :feature,
        "andy-pankhurst" => :artist,
        "thewarholmuseum" => :profile,
        "wendi" => :profile,
        "andy-burgess" => :artist,
        "andy-holden" => :artist,
        "andy-decola" => :artist,
        "andy-cross" => :artist,
        "andy-yoder" => :artist
      }.each_pair do |id, klass|
        stub_get("/api/v1/#{klass}/#{id}").to_return({
          :body => fixture("#{klass}.json"),
          :headers => { :content_type => "application/json; charset=utf-8" }
        })
      end
    end
    it "returns matching instances" do
      matches = @client.match('andy')
      expect(a_get("/api/v1/match?term=andy")).to have_been_made
      expect(matches).to be_an Array
      expect(matches.size).to eq 10
      matches.each do |match|
        expect(match.object).to be_an Artsy::Client::Base
      end
      first = matches.first
      expect(first).to be_an Artsy::Client::Domain::Match
      expect(first.to_s).to eq "Andy Warhol, Presented by Christie’s"
      expect(first.object).to be_an Artsy::Client::Domain::Feature
      expect(first.object.to_s).to eq "TWO x TWO"
      last = matches.last
      expect(last).to be_an Artsy::Client::Domain::Match
      expect(last.to_s).to eq "Andy Pankhurst"
      expect(last.object).to be_an Artsy::Client::Domain::Artist
      expect(last.object.to_s).to eq "Andy Warhol"
    end
  end
end

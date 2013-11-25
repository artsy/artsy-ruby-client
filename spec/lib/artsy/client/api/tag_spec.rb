require 'spec_helper'

describe Artsy::Client::API::Tag do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#tag" do
    before do
      stub_get("/api/v1/tag/cow").to_return({
        :body => fixture("tag.json"),
        :headers => { :content_type => "application/json; charset=utf-8" }
      })
    end
    it "returns tag" do
      tag = @client.tag('cow')
      expect(a_get("/api/v1/tag/cow")).to have_been_made
      expect(tag).to be_an Artsy::Client::Domain::Tag
      expect(tag.name).to eq "Cow"
    end
  end
end

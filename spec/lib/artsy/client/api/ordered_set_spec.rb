require 'spec_helper'

describe Artsy::Client::API::OrderedSet do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#ordered_set" do
    before do
      stub_get("/api/v1/set/two-x-two").to_return(
        body: fixture("ordered_set.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns ordered_set" do
      ordered_set = @client.ordered_set('two-x-two')
      expect(a_get("/api/v1/set/two-x-two")).to have_been_made
      expect(ordered_set).to be_an Artsy::Client::Domain::OrderedSet
      expect(ordered_set.name).to eq "Beneficiaries"
    end
  end
  describe "#create_ordered_set" do
    before do
      stub_post("/api/v1/set").to_return(
        body: fixture("ordered_set.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns ordered_set" do
      ordered_set = @client.create_ordered_set(key: 'Beneficiaries')
      expect(a_post("/api/v1/set")).to have_been_made
      expect(ordered_set).to be_an(Artsy::Client::Domain::OrderedSet)
      expect(ordered_set.name).to eq('Beneficiaries')
    end
  end
  describe "#add_to_ordered_set" do
    before do
      stub_post("/api/v1/set/two-x-two/item").to_return(
        body: fixture("artwork.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
      # ordered set will have to make a request to fetch the set's item_type
      stub_get("/api/v1/set/two-x-two").to_return(
        body: fixture("ordered_set.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns the item you added" do
      item = @client.add_to_ordered_set('two-x-two', item_id: 'andy-warhol-skull')
      expect(a_post("/api/v1/set/two-x-two/item")).to have_been_made
      expect(item).to be_an(Artsy::Client::Domain::Artwork)
      expect(item.title).to eq('Skull')
    end
  end
end

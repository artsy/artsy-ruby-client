require 'spec_helper'

describe Artsy::Client::API::SearchQuery do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#search_queries" do
    before do
      stub_get("/api/v1/autocomplete?term=").to_return(
        body: fixture("autocomplete.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns search queries" do
      search_queries = @client.autocomplete
      expect(a_get("/api/v1/autocomplete?term=")).to have_been_made
      expect(search_queries).to be_an Array
      expect(search_queries.size).to eq 10
      expect(search_queries.first.query).to eq "banksy"
    end
  end
end

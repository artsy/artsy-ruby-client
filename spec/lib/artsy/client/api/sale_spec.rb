require 'spec_helper'

describe Artsy::Client::API::Sale do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#sale" do
    before do
      stub_get("/api/v1/sale/two-x-two").to_return(
        body: fixture("sale.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns sale" do
      sale = @client.sale('two-x-two')
      expect(a_get("/api/v1/sale/two-x-two")).to have_been_made
      expect(sale).to be_an Artsy::Client::Domain::Sale
      expect(sale.name).to eq "TWO x TWO"
    end
  end
  describe "#create_sale" do
    before do
      stub_post("/api/v1/sale").to_return(
        body: fixture("sale.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns sale" do
      sale = @client.create_sale(name: 'TWO x TWO')
      expect(a_post("/api/v1/sale")).to have_been_made
      expect(sale).to be_an(Artsy::Client::Domain::Sale)
      expect(sale.name).to eq('TWO x TWO')
    end
  end
  describe "#update_sale" do
    before do
      stub_put("/api/v1/sale/two-x-two").to_return(
        body: fixture("sale.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns sale" do
      sale = @client.update_sale('two-x-two', name: "TWO x TWO")
      expect(a_put("/api/v1/sale/two-x-two")).to have_been_made
      expect(sale).to be_an Artsy::Client::Domain::Sale
      expect(sale.name).to eq "TWO x TWO"
    end
  end
end

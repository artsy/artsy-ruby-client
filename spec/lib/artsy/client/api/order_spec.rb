require 'spec_helper'

describe Artsy::Client::API::Me do
  before do
    @client = Artsy::Client::Instance.new
  end
  describe "#me" do
    before do
      stub_get("/api/v1/orders").to_return(
        body: fixture("orders.json"),
        headers: { content_type: "application/json; charset=utf-8" }
      )
    end
    it "returns orders" do
      orders = @client.orders
      expect(a_get("/api/v1/orders")).to have_been_made
      expect(orders).to be_an Array
      order = orders.first
      expect(order).to be_an Artsy::Client::Domain::Order
      expect(order.state).to eq "pending"
    end
  end
end
